// Run after the IG build: node scripts/check-form111-contract.cjs [integration-document.md]
// The baseline protects semantic identity, rather than merely checking that a code exists.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const root = path.resolve(__dirname, '..');
const generated = path.join(root, 'fsh-generated/resources');
const baseline = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures/form111-code-identities.json'), 'utf8'));
const resources = fs.readdirSync(generated).filter(f => f.endsWith('.json')).map(f => JSON.parse(fs.readFileSync(path.join(generated, f), 'utf8')));
const systems = new Map();
for (const cs of resources.filter(r => r.resourceType === 'CodeSystem' && r.content !== 'supplement')) {
  assert(!systems.has(cs.url), `Duplicate CodeSystem canonical: ${cs.url}`);
  const concepts = new Map();
  function index(items) {
    for (const c of items || []) {
      assert(!concepts.has(c.code), `Duplicate code: ${cs.url}#${c.code}`);
      concepts.set(c.code, c);
      index(c.concept);
    }
  }
  index(cs.concept);
  systems.set(cs.url, { resource: cs, concepts });
}
for (const c of baseline.concepts) {
  const actual = systems.get(c.system)?.concepts.get(c.code);
  assert(actual, `Removed legacy concept: ${c.system}#${c.code}`);
  assert.equal(actual.display, c.display, `Reassigned legacy concept: ${c.system}#${c.code}`);
}
const formSystems = [...systems].filter(([url]) => /\/form111(?:113)?-/.test(url));
const localCodes = new Map();
for (const [url, { concepts }] of formSystems) {
  for (const code of concepts.keys()) {
    assert(!localCodes.has(code), `Ambiguous local Form 111 code: ${code} in ${url} and ${localCodes.get(code)}`);
    localCodes.set(code, url);
  }
}
function checkCoding(c, location) {
  if (!c || typeof c !== 'object' || typeof c.code !== 'string' || !c.code.startsWith('chr-')) return;
  const concept = systems.get(c.system)?.concepts.get(c.code);
  assert(concept, `Unresolved coding at ${location}: ${c.system}#${c.code}`);
  if (c.display) {
    const displays = [concept.display, ...(concept.designation || []).map(d => d.value)];
    assert(displays.includes(c.display), `Conflicting coding display at ${location}: ${c.code} / ${c.display}`);
  }
}
function walk(value, fn, location = '') {
  if (!value || typeof value !== 'object') return;
  fn(value, location);
  for (const [key, child] of Object.entries(value)) walk(child, fn, `${location}.${key}`);
}
const bundle = resources.find(r => r.resourceType === 'Bundle' && r.id === 'example-form-111-pregnant-woman-individual-card');
assert(bundle, 'Missing Form 111 document example');
walk(bundle, checkCoding, 'Form111');
const maps = resources.filter(r => r.resourceType === 'ConceptMap' && r.id.startsWith('dmed-form-111-'));
for (const cm of maps) {
  for (const group of cm.group || []) {
    for (const element of group.element || []) {
      const source = systems.get(group.source);
      if (source) assert(source.concepts.has(element.code), `Unknown source token in ${cm.id}: ${element.code}`);
      for (const target of element.target || []) checkCoding({ system: group.target, ...target }, `${cm.id}/${element.code}`);
    }
  }
}
function targets(map, token) {
  const cm = maps.find(m => m.id === map);
  assert(cm, `Missing map ${map}`);
  return (cm.group || []).flatMap(g => (g.element || []).filter(e => e.code === token).flatMap(e => (e.target || []).map(t => ({ system: g.target, code: t.code }))));
}
const integrationCS = 'https://terminology.dhp.uz/fhir/integrations/CodeSystem/';
const sct = 'http://snomed.info/sct';
for (const [map, token, system, code] of [
  ['dmed-form-111-patient-bad-habits-cm', 'smoking', sct, '77176002'],
  ['dmed-form-111-fetal-presentation-cm', 'cephalic', sct, '1209182005'],
  ['dmed-form-111-pregnancy-progress-pregnancy-complications-cm', 'anemia', sct, '271737000'],
  ['dmed-form-111-extragenital-diseases-cm', 'alcoholism_drug_addiction', integrationCS + 'form111-extragenital-disease-factor-cs', 'chr-0012-00002'],
  ['dmed-form-111-socio-biological-factors-cm', 'smoking_alcoholism_drug_addiction', integrationCS + 'form111-socio-biological-factor-cs', 'chr-0028-00005'],
  ['dmed-form-111-pregnancy-progress-pregnancy-complications-cm', 'gestosis', integrationCS + 'form111-pregnancy-complication-factor-cs', 'chr-0022-00005'],
]) assert.deepEqual(targets(map, token), [{ system, code }], `Incorrect or ambiguous mapping for ${token}`);
const observations = bundle.entry.map(e => e.resource).filter(r => r.resourceType === 'Observation');
const hasCode = (o, system, code) => (o.code?.coding || []).some(c => c.system === system && c.code === code);
for (const [system, code, value] of [
  ['http://loinc.org', '57088-7', true],
  [integrationCS + 'form111-general-observation-code-cs', 'chr-0035-00019', false],
]) {
  const matches = observations.filter(o => hasCode(o, system, code));
  assert(matches.length, `Missing boolean example for ${code}`);
  for (const o of matches) { assert.equal(o.valueBoolean, value); assert(!o.valueCodeableConcept); }
}
for (const code of ['chr-0025-00001', 'chr-0025-00002', 'chr-0025-00003', 'chr-0025-00004']) {
  const observation = observations.find(o => hasCode(o, integrationCS + 'form111-preparation-activity-cs', code));
  assert(observation?.valueDateTime, `Activity date must be a result: ${code}`);
  assert(!observation.valueBoolean && !observation.component, `Invented activity completion/frequency: ${code}`);
}
const previous = resources.find(r => r.resourceType === 'ValueSet' && r.id === 'form111-previous-pregnancy-outcome-vs');
assert.deepEqual(previous?.compose?.include?.flatMap(i => i.concept.map(c => `${i.system}#${c.code}`)).sort(), [`${sct}#386639001`, `${sct}#3950001`].sort());
const generalVS = resources.find(r => r.resourceType === 'ValueSet' && r.id === 'form111-general-observation-code-vs');
for (const code of ['chr-0035-00022', 'chr-0035-00023']) {
  assert(systems.get(integrationCS + 'form111-general-observation-code-cs').concepts.get(code).property.some(p => p.code === 'status' && p.valueCode === 'deprecated'));
  assert(generalVS.compose.exclude.some(i => i.system === integrationCS + 'form111-general-observation-code-cs' && i.concept.some(c => c.code === code)));
}
if (process.argv[2]) {
  const doc = fs.readFileSync(path.resolve(process.argv[2]), 'utf8');
  for (const old of ['165747005', '165748000', '112141000', '112142007', '112143002']) assert(!doc.includes(old), `Obsolete blood-group/Rh code in document: ${old}`);
  for (const match of doc.matchAll(/```json\s*\n([\s\S]*?)```/g)) walk(JSON.parse(match[1]), checkCoding, 'Integration document');
}
console.log(`PASS: ${baseline.concepts.length} preserved code identities, ${localCodes.size} unique Form 111 codes, ${maps.length} ConceptMaps, example and source-contract checks.`);
