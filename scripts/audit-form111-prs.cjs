// Read-only audit against fetched Git revisions. No network calls are made.
// Usage: node scripts/audit-form111-prs.cjs revisions.json > report.json
// revisions.json: { "revisions": [{ "name": "main", "ref": "<commit-or-ref>" }, ...] }
const fs = require('node:fs');
const path = require('node:path');
const cp = require('node:child_process');
const root = path.resolve(__dirname, '..');
const fixture = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures/form111-code-identities.json'), 'utf8'));
const baseline = new Map(fixture.concepts.map(c => [`${c.system}#${c.code}`, c]));
const manifest = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
function git(...args) {
  return cp.execFileSync('git', ['-C', root, ...args], { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 });
}
const results = [];
for (const revision of manifest.revisions) {
  const commit = git('rev-parse', revision.ref).trim();
  const files = new Map();
  const output = git('grep', '-n', '-E', '^(CodeSystem:|Id:|\\* insert (Original|Supplement)CodeSystem|\\* \\^url =|\\* #)', commit, '--', 'input/fsh', 'input/manual-fsh');
  for (const line of output.split('\n')) {
    const m = line.match(/^[^:]+:(.*?):(\d+):(.*)$/);
    if (!m) continue;
    if (!files.has(m[1])) files.set(m[1], []);
    files.get(m[1]).push({ line: Number(m[2]), text: m[3] });
  }
  const concepts = [];
  for (const [file, lines] of files) {
    if (!lines.some(l => l.text.startsWith('CodeSystem: '))) continue;
    if (lines.some(l => /insert Supplement/.test(l.text))) continue;
    const id = lines.find(l => l.text.startsWith('Id: '))?.text.slice(4).trim();
    if (!id) continue;
    const system = lines.find(l => l.text.startsWith('* ^url = '))?.text.match(/"([^"]+)"/)?.[1]
      || `https://terminology.dhp.uz/fhir/integrations/CodeSystem/${id}`;
    for (const { line, text } of lines) {
      const m = text.match(/^\* #([^\s"]+)\s+"([^"]+)"/);
      if (m) concepts.push({ system, code: m[1], display: m[2], file, line });
    }
  }
  const jsonFiles = git('ls-tree', '-r', '--name-only', commit, 'input/vocabulary').trim().split('\n').filter(f => /CodeSystem.*\.json$/.test(f));
  for (const file of jsonFiles) {
    const cs = JSON.parse(git('show', `${commit}:${file}`));
    if (cs.content === 'supplement') continue;
    function visit(items) {
      for (const c of items || []) {
        concepts.push({ system: cs.url, code: c.code, display: c.display, file });
        visit(c.concept);
      }
    }
    visit(cs.concept);
  }
  const conflicts = [];
  for (const c of concepts) {
    const previous = baseline.get(`${c.system}#${c.code}`);
    if (previous && previous.display !== c.display) conflicts.push({ original: previous, other: c });
  }
  results.push({ name: revision.name, commit, conflicts });
}
console.log(JSON.stringify({ source: fixture.source, conceptsChecked: baseline.size, results }, null, 2));
if (results.some(r => r.conflicts.length)) process.exitCode = 1;
