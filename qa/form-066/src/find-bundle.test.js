// Finds the form 066 document Bundle(s) for {{hospitalization_id}} among the search results.
// DHP stores the document as a Bundle; the link to the hospitalization is
// Bundle.entry[0] (Composition).encounter -> Encounter.identifier.value.
const hospId = String(pm.variables.get('hospitalization_id') || '').trim();

pm.test('Search returned 200 searchset', () => {
  pm.response.to.have.status(200);
  pm.expect(pm.response.json().type).to.eql('searchset');
});

const body = pm.response.json();
const docs = (body.entry || []).map(e => e.resource).filter(r => r && r.resourceType === 'Bundle');

function encounterIdsOf(bundle) {
  const entries = bundle.entry || [];
  const comp = entries[0] && entries[0].resource;
  if (!comp || comp.resourceType !== 'Composition' || !comp.encounter) return [];
  const ref = comp.encounter.reference;
  const enc = entries.map(e => e.resource).find((r, i) =>
    r && r.resourceType === 'Encounter' &&
    (entries[i].fullUrl === ref || `Encounter/${r.id}` === ref || (ref || '').endsWith(`/Encounter/${r.id}`)));
  return enc ? (enc.identifier || []).map(i => String(i.value)) : [];
}

function isForm066(bundle) {
  const comp = bundle.entry && bundle.entry[0] && bundle.entry[0].resource;
  if (!comp || comp.resourceType !== 'Composition') return false;
  const prof = (comp.meta && comp.meta.profile) || [];
  const cats = (comp.category || []).flatMap(c => c.coding || []).map(c => c.code);
  return prof.some(p => p.includes('form-066-hospital-discharge')) || cats.includes('form-066');
}

const matches = docs.filter(b => isForm066(b) && encounterIdsOf(b).includes(hospId));

pm.test(`hospitalization_id is set (${hospId || 'EMPTY'})`, () => pm.expect(hospId).to.not.be.empty);

pm.test('Exactly one form 066 document Bundle exists for this hospitalization (re-save replaces, never duplicates)', () => {
  pm.expect(matches.length, `found ${matches.length}: ${matches.map(b => b.id).join(', ')}`).to.eql(1);
});

if (matches.length) {
  // newest first if several (so the detail checks still run on the latest one)
  matches.sort((a, b) => String((b.meta || {}).lastUpdated || b.timestamp).localeCompare(String((a.meta || {}).lastUpdated || a.timestamp)));
  pm.collectionVariables.set('bundle_id', matches[0].id);
  console.log(`form 066 Bundle for hospitalization ${hospId}: Bundle/${matches[0].id}`);
} else {
  pm.collectionVariables.unset('bundle_id');
  console.log(`no form 066 Bundle found for hospitalization ${hospId} among ${docs.length} document Bundles; ` +
    'raise search_count or set bundle_id manually');
}
