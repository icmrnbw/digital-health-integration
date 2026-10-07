// Assembles form-066-dhp-qa.postman_collection.json and the environment template.
const fs = require('fs');
const path = require('path');
const [, , outDir] = process.argv;
const here = __dirname;
const read = f => fs.readFileSync(path.join(here, f), 'utf8');
const lines = s => s.split('\n');

const cm = read('conceptmaps.json');
const check = read('check-bundle.test.js').replace('__CONCEPTMAPS__', cm.trim());
const find = read('find-bundle.test.js');

const skipIf = cond => lines(`if (${cond}) { pm.execution.skipRequest(); }`);
const ev = (listen, exec) => ({ listen, script: { type: 'text/javascript', exec: Array.isArray(exec) ? exec : lines(exec) } });
const url = raw => raw;

const collection = {
  info: {
    name: 'Form 066 – DHP verification (DMED integration QA)',
    description: 'Finds the form 066 document Bundle that DMED sent to DHP for {{hospitalization_id}} and checks it against integration-066 v1.9 (US1–US9). Set dmed_form_json to the DMED form JSON for field-by-field comparison.',
    schema: 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json',
  },
  auth: { type: 'bearer', bearer: [{ key: 'token', value: '{{access_token}}', type: 'string' }] },
  variable: [{ key: 'bundle_id', value: '' }, { key: 'last_composition_id', value: '' }],
  item: [
    {
      name: '0. Get access token (client_credentials)',
      event: [
        ev('prerequest', skipIf("pm.variables.get('access_token') || !pm.variables.get('client_id')")),
        ev('test', `
pm.test('token endpoint returned 200', () => pm.response.to.have.status(200));
const t = pm.response.json().access_token;
pm.test('access_token received', () => pm.expect(t).to.be.a('string'));
if (t) pm.environment.set('access_token', t);`),
      ],
      request: {
        auth: { type: 'noauth' },
        method: 'POST',
        header: [{ key: 'Content-Type', value: 'application/x-www-form-urlencoded' }],
        body: { mode: 'urlencoded', urlencoded: [
          { key: 'grant_type', value: 'client_credentials' },
          { key: 'client_id', value: '{{client_id}}' },
          { key: 'client_secret', value: '{{client_secret}}' },
        ] },
        url: url('{{token_url}}'),
      },
    },
    {
      name: '1. Server smoke: CapabilityStatement',
      event: [ev('test', `
pm.test('metadata returned 200', () => pm.response.to.have.status(200));
const cs = pm.response.json();
pm.test('FHIR R5 server', () => pm.expect(String(cs.fhirVersion)).to.match(/^5\\./));
pm.test('Bundle resource is exposed', () =>
  pm.expect((cs.rest || []).flatMap(r => r.resource || []).map(r => r.type)).to.include('Bundle'));`)],
      request: { method: 'GET', header: [{ key: 'Accept', value: 'application/fhir+json' }], url: url('{{fhir_base}}/metadata') },
    },
    {
      name: '2. Find the form 066 document Bundle for the hospitalization',
      event: [ev('test', find)],
      request: {
        method: 'GET', header: [{ key: 'Accept', value: 'application/fhir+json' }],
        url: url('{{fhir_base}}/Bundle?type=document&_sort=-_lastUpdated&_count={{search_count}}'),
      },
    },
    {
      name: '3. Read the Bundle and check it against integration-066',
      event: [
        ev('prerequest', skipIf("!pm.variables.get('bundle_id')")),
        ev('test', check + `\npm.collectionVariables.set('bundle_json', pm.response.text());`),
      ],
      request: { method: 'GET', header: [{ key: 'Accept', value: 'application/fhir+json' }], url: url('{{fhir_base}}/Bundle/{{bundle_id}}') },
    },
    {
      name: '4. Profile validation: Bundle/$validate',
      event: [
        ev('prerequest', skipIf("!pm.variables.get('bundle_json') || pm.variables.get('skip_validate') === 'true'")),
        ev('test', `
pm.test('$validate answered (200 or 422 with OperationOutcome)', () => pm.expect(pm.response.code).to.be.oneOf([200, 400, 422]));
let oo = {}; try { oo = pm.response.json(); } catch (e) {}
const errs = (oo.issue || []).filter(i => ['error', 'fatal'].includes(i.severity));
errs.slice(0, 30).forEach(i => console.log('validate:', i.severity, (i.expression || i.location || []).join(','), (i.details || {}).text || i.diagnostics));
pm.test('no error/fatal issues from $validate (' + errs.length + ' found)', () => pm.expect(errs).to.have.length(0));`),
      ],
      request: {
        method: 'POST',
        header: [{ key: 'Content-Type', value: 'application/fhir+json' }, { key: 'Accept', value: 'application/fhir+json' }],
        body: { mode: 'raw', raw: '{{bundle_json}}' },
        url: url('{{fhir_base}}/Bundle/$validate'),
      },
    },
    {
      name: '5. Info: is the Encounter also stored as a standalone resource?',
      event: [ev('test', `
pm.test('Encounter search answered', () => pm.response.to.have.status(200));
const n = (pm.response.json().entry || []).length;
console.log('standalone Encounter?identifier={{hospitalization_id}} matches: ' + n);
if (pm.variables.get('expect_standalone_resources') === 'true')
  pm.test('Encounter is searchable by hospitalization_id', () => pm.expect(n).to.be.at.least(1));`)],
      request: { method: 'GET', header: [{ key: 'Accept', value: 'application/fhir+json' }], url: url('{{fhir_base}}/Encounter?identifier={{hospitalization_id}}') },
    },
  ],
};

const env = {
  name: 'DHP playground – form 066 QA',
  values: [
    ['fhir_base', 'https://playground.dhp.uz/fhir'],
    ['token_url', ''],
    ['client_id', ''],
    ['client_secret', '', 'secret'],
    ['access_token', '', 'secret'],
    ['hospitalization_id', ''],
    ['dmed_form_json', ''],
    ['previous_composition_id', ''],
    ['search_count', '100'],
    ['skip_validate', 'false'],
    ['expect_standalone_resources', 'false'],
  ].map(([key, value, type]) => ({ key, value, type: type || 'default', enabled: true })),
};

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, 'form-066-dhp-qa.postman_collection.json'), JSON.stringify(collection, null, 2));
fs.writeFileSync(path.join(outDir, 'dhp-playground.postman_environment.json'), JSON.stringify(env, null, 2));
console.log('written to', outDir);
