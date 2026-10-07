// Local stand-in for the DHP FHIR server, used only to self-test the collection.
// Serves the given document Bundle(s) under /fhir/Bundle.
const http = require('http');
const fs = require('fs');
const [, , port, ...files] = process.argv;
const bundles = files.map(f => JSON.parse(fs.readFileSync(f, 'utf8')));
const send = (res, code, body) => { res.writeHead(code, { 'Content-Type': 'application/fhir+json' }); res.end(JSON.stringify(body)); };
http.createServer((req, res) => {
  const u = new URL(req.url, 'http://x');
  if (u.pathname === '/token') return send(res, 200, { access_token: 'mock', token_type: 'Bearer' });
  if (u.pathname === '/fhir/metadata') return send(res, 200, { resourceType: 'CapabilityStatement', fhirVersion: '5.0.0', rest: [{ resource: [{ type: 'Bundle' }, { type: 'Encounter' }] }] });
  if (u.pathname === '/fhir/Bundle') return send(res, 200, { resourceType: 'Bundle', type: 'searchset', entry: bundles.map(b => ({ resource: b })) });
  if (u.pathname === '/fhir/Bundle/$validate') return send(res, 200, { resourceType: 'OperationOutcome', issue: [{ severity: 'information', code: 'informational' }] });
  const m = u.pathname.match(/^\/fhir\/Bundle\/(.+)$/);
  if (m) { const b = bundles.find(x => x.id === m[1]); return b ? send(res, 200, b) : send(res, 404, {}); }
  if (u.pathname === '/fhir/Encounter') return send(res, 200, { resourceType: 'Bundle', type: 'searchset', entry: [] });
  send(res, 404, {});
}).listen(Number(port), () => console.log('mock DHP on', port));
