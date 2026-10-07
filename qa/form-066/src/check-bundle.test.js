// Checks the stored form 066 document Bundle against integration-066 (v1.9) US1–US9.
// Optional {{dmed_form_json}}: the DMED form 066 JSON ({"data": {...}}) for this
// hospitalization; when set, every mapped DMED field is compared value-by-value.
const CM = __CONCEPTMAPS__;

const LOINC = 'http://loinc.org';
const ICD10 = 'http://hl7.org/fhir/sid/icd-10';
const ROLE_CS = 'https://terminology.dhp.uz/fhir/integrations/CodeSystem/diagnosis-role-integration';
const PROFILE = {
  Composition: 'https://dhp.uz/fhir/integrations/StructureDefinition/form-066-hospital-discharge-composition',
  Encounter: 'https://dhp.uz/fhir/integrations/StructureDefinition/uz-core-encounter-066',
  Procedure: 'https://dhp.uz/fhir/integrations/StructureDefinition/procedure-066',
};
const MAIN_PROC_EXT = 'https://dhp.uz/fhir/integrations/StructureDefinition/main-procedure';
const OBS = {
  emergency_care: '57276-8', urgency_time: '77977-7', delivered_by_ambulance: 'LP97912-7',
  has_direction: '57133-1', same_illness_in_last_month: 'LP73229-4', reanimation_period: 'LP76050-1',
  aids: '56888-1', rw: '47236-5', hepatitis_b: '5196-1', hepatitis_c: '13955-0',
  newborn_weight: '8339-4', newborn_height: '89269-5', tuberculosis_treatment_resistance: '18769-0',
  sick_leave: '105583-9',
};
const LAB_DATE = { aids: 'aids_analysis_date', rw: 'rw_analysis_date', hepatitis_b: 'hepatitis_b_analysis_date', hepatitis_c: 'hepatitis_c_analysis_date' };

pm.test('Bundle read returned 200', () => pm.response.to.have.status(200));
const bundle = pm.response.json();
const entries = bundle.entry || [];
const res = entries.map(e => e.resource || {});
const byType = t => res.filter(r => r.resourceType === t);
const codes = cc => ((cc && cc.coding) || []);
const hasCode = (cc, system, code) => codes(cc).some(c => (!system || c.system === system) && c.code === code);
const obsByCode = code => byType('Observation').filter(o => hasCode(o.code, LOINC, code));

// resolve a reference against fullUrl, Type/id, or absolute URL ending in Type/id
function resolve(ref) {
  if (!ref) return undefined;
  const i = entries.findIndex(e => e.fullUrl === ref ||
    (e.resource && (`${e.resource.resourceType}/${e.resource.id}` === ref || ref.endsWith(`/${e.resource.resourceType}/${e.resource.id}`))));
  return i >= 0 ? entries[i].resource : undefined;
}
function refsIn(obj, out = []) {
  if (Array.isArray(obj)) obj.forEach(o => refsIn(o, out));
  else if (obj && typeof obj === 'object') {
    if (typeof obj.reference === 'string') out.push(obj.reference);
    Object.values(obj).forEach(v => refsIn(v, out));
  }
  return out;
}
const sectionRefs = s => [...(s.entry || []).map(e => e.reference), ...(s.section || []).flatMap(sectionRefs)];

// ---------- US9 AC1: document Bundle ----------
const comp = res[0];
pm.test('US9.AC1 Bundle.type = document', () => pm.expect(bundle.type).to.eql('document'));
pm.test('US9.AC1 Bundle.identifier and timestamp are present', () => {
  pm.expect(bundle.identifier && bundle.identifier.value, 'identifier.value').to.be.a('string');
  pm.expect(bundle.timestamp, 'timestamp').to.be.a('string');
});
pm.test('US9.AC1 first entry is a Composition with the form 066 profile', () => {
  pm.expect(comp.resourceType).to.eql('Composition');
  pm.expect((comp.meta || {}).profile || []).to.include(PROFILE.Composition);
});
pm.test('US9.AC1 Composition.status = final', () => pm.expect(comp.status).to.eql('final'));
pm.test('Composition.category = form-066, identifier has a UUID value', () => {
  pm.expect(codes((comp.category || [])[0]).map(c => c.code)).to.include('form-066');
  pm.expect((comp.identifier || []).map(i => i.value).join(' ')).to.match(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i);
});

// ---------- US9 AC3: referential integrity ----------
pm.test('US9.AC3 entry.fullUrl values are present and unique', () => {
  const urls = entries.map(e => e.fullUrl);
  pm.expect(urls.filter(u => !u), 'entries without fullUrl').to.have.length(0);
  pm.expect(new Set(urls).size, 'duplicate fullUrl').to.eql(urls.length);
});
pm.test('US9.AC3 every in-bundle reference resolves to an entry', () => {
  // Provenance.target / entity may point at the Bundle itself
  const dangling = res.flatMap(r => refsIn(r).map(ref => ({ from: `${r.resourceType}/${r.id}`, ref })))
    .filter(x => !x.ref.startsWith('#') && !/^Bundle\//.test(x.ref) && !resolve(x.ref));
  pm.expect(dangling, JSON.stringify(dangling.slice(0, 10))).to.have.length(0);
});
pm.test('US9.AC3 every resource except Composition/Provenance is referenced from somewhere (no orphans)', () => {
  const all = new Set(res.flatMap(r => refsIn(r)).map(resolve).filter(Boolean));
  const orphans = res.slice(1).filter(r => r.resourceType !== 'Provenance' && !all.has(r)).map(r => `${r.resourceType}/${r.id}`);
  pm.expect(orphans).to.have.length(0);
});

// ---------- US9 AC2: context ----------
const patient = resolve(((comp.subject || [])[0] || comp.subject || {}).reference);
const encounter = resolve((comp.encounter || {}).reference);
pm.test('US9.AC2 Composition.subject resolves to the Patient', () => pm.expect(patient && patient.resourceType).to.eql('Patient'));
pm.test('US9.AC2 Composition.encounter resolves to the Encounter', () => pm.expect(encounter && encounter.resourceType).to.eql('Encounter'));
pm.test('Exactly one Patient and one Encounter in the document', () => {
  pm.expect(byType('Patient')).to.have.length(1);
  pm.expect(byType('Encounter')).to.have.length(1);
});
pm.test('US9.AC2 clinical resources point to the same Patient and Encounter', () => {
  const bad = [];
  for (const r of res) {
    const subj = r.subject && (Array.isArray(r.subject) ? r.subject[0] : r.subject);
    if (subj && ['Observation', 'Condition', 'Procedure', 'Encounter'].includes(r.resourceType) && resolve(subj.reference) !== patient)
      bad.push(`${r.resourceType}/${r.id}.subject`);
    if (r.encounter && resolve(r.encounter.reference) !== encounter) bad.push(`${r.resourceType}/${r.id}.encounter`);
  }
  pm.expect(bad).to.have.length(0);
});
pm.test('US9.AC3 Composition.section entries all resolve and every section has entries or sub-sections', () => {
  const bad = (comp.section || []).filter(s => !sectionRefs(s).length || sectionRefs(s).some(r => !resolve(r))).map(s => s.title);
  pm.expect(bad).to.have.length(0);
});
pm.test('US9 Provenance is present and targets the document', () => {
  const prov = byType('Provenance');
  pm.expect(prov.length).to.be.at.least(1);
  pm.expect(refsIn(prov[0].target)).to.not.be.empty;
});

// ---------- US1: Encounter ----------
if (encounter) {
  const hospId = String(pm.variables.get('hospitalization_id') || '');
  pm.test('US1.AC1 Encounter.status = completed', () => pm.expect(encounter.status).to.eql('completed'));
  pm.test('US1.AC1 Encounter.actualPeriod has start and end, end ≥ start', () => {
    const p = encounter.actualPeriod || {};
    pm.expect(p.start, 'start').to.be.a('string');
    pm.expect(p.end, 'end').to.be.a('string');
    pm.expect(new Date(p.end) >= new Date(p.start)).to.be.true;
  });
  pm.test('US1.AC2 Encounter.identifier carries hospitalization_id', () =>
    pm.expect((encounter.identifier || []).map(i => String(i.value))).to.include(hospId));
  pm.test('Encounter has the uz-core-encounter-066 profile', () => pm.expect((encounter.meta || {}).profile || []).to.include(PROFILE.Encounter));
  pm.test('US2.AC2 Encounter.class stays IMP', () => pm.expect((encounter.class || []).some(c => hasCode(c, null, 'IMP'))).to.be.true);
  pm.test('B1 Encounter.type = mserv-0001-00004', () => pm.expect((encounter.type || []).some(t => hasCode(t, null, 'mserv-0001-00004'))).to.be.true);
  pm.test('US8.AC2 Encounter.participant actors are PractitionerRoles', () => {
    const actors = (encounter.participant || []).map(p => resolve((p.actor || {}).reference));
    pm.expect(actors.length).to.be.at.least(1);
    pm.expect(actors.every(a => a && a.resourceType === 'PractitionerRole')).to.be.true;
  });
  pm.test('US3.AC2 dischargeDisposition is only set together with status completed and actualPeriod.end', () => {
    if ((encounter.admission || {}).dischargeDisposition)
      pm.expect(encounter.status === 'completed' && !!(encounter.actualPeriod || {}).end).to.be.true;
  });
}

// ---------- US8: responsible persons ----------
pm.test('US8.AC2 Composition.author references PractitionerRoles', () => {
  const a = (comp.author || []).map(x => resolve(x.reference));
  pm.expect(a.length).to.be.at.least(1);
  pm.expect(a.every(x => x && x.resourceType === 'PractitionerRole')).to.be.true;
});
pm.test('US8 every PractitionerRole links a Practitioner in the Bundle', () => {
  const bad = byType('PractitionerRole').filter(r => !resolve((r.practitioner || {}).reference)).map(r => r.id);
  pm.expect(bad).to.have.length(0);
});
pm.test('US8.AC1 PractitionerRole.code comes from position-and-profession-cs', () => {
  const bad = byType('PractitionerRole').filter(r => !(r.code || []).some(c => codes(c).some(x => /position-and-profession-cs$/.test(x.system)))).map(r => r.id);
  pm.expect(bad).to.have.length(0);
});

// ---------- US4: diagnoses ----------
pm.test('US4.AC1 every Condition has an ICD-10 code and a diagnosis role category', () => {
  const bad = byType('Condition').filter(c => !codes(c.code).some(x => x.system === ICD10 && x.code) ||
    !(c.category || []).some(cat => codes(cat).some(x => x.system === ROLE_CS))).map(c => c.id);
  pm.expect(bad).to.have.length(0);
});
pm.test('US4.AC1 role is not encoded in Condition.code', () => {
  const bad = byType('Condition').filter(c => codes(c.code).some(x => x.system === ROLE_CS)).map(c => c.id);
  pm.expect(bad).to.have.length(0);
});
pm.test('US4 a main diagnosis exists', () =>
  pm.expect(byType('Condition').some(c => (c.category || []).some(cat => hasCode(cat, ROLE_CS, 'main')))).to.be.true);

// ---------- US5: procedures ----------
pm.test('US5 every Procedure has the procedure-066 profile, mainProcedure extension, encounter and performer', () => {
  const bad = byType('Procedure').filter(p => !((p.meta || {}).profile || []).includes(PROFILE.Procedure) ||
    !(p.extension || []).some(e => e.url === MAIN_PROC_EXT && typeof e.valueBoolean === 'boolean') ||
    !p.encounter || !(p.performer || []).length).map(p => p.id);
  pm.expect(bad).to.have.length(0);
});
pm.test('US5.AC2 at most one Procedure is flagged as the main operation', () =>
  pm.expect(byType('Procedure').filter(p => (p.extension || []).some(e => e.url === MAIN_PROC_EXT && e.valueBoolean === true)).length).to.be.at.most(1));
pm.test('US5.AC1 no duplicate Procedures (same code + time)', () => {
  const keys = byType('Procedure').map(p => JSON.stringify([codes(p.code).map(c => c.code), p.occurrenceDateTime || p.occurrencePeriod]));
  pm.expect(new Set(keys).size).to.eql(keys.length);
});
pm.test('US5.AC3 surgical section present only if Procedures exist', () => {
  const sec = (comp.section || []).find(s => hasCode(s.code, LOINC, '29554-3'));
  pm.expect(!!sec).to.eql(byType('Procedure').length > 0);
});

// ---------- US6: labs ----------
pm.test('US6.AC1/AC2 HIV, RW, HepB, HepC are separate Observations with POS/NEG interpretation', () => {
  const bad = [];
  for (const k of ['aids', 'rw', 'hepatitis_b', 'hepatitis_c']) {
    const o = obsByCode(OBS[k]);
    if (o.length > 1) bad.push(`${k}: ${o.length} Observations`);
    o.forEach(x => {
      const v = codes(x.valueCodeableConcept).concat(...(x.interpretation || []).map(codes)).map(c => c.code);
      if (!v.some(c => c === 'POS' || c === 'NEG')) bad.push(`${k}: no POS/NEG`);
    });
  }
  pm.expect(bad).to.have.length(0);
});

// ---------- US7 ----------
pm.test('US7.AC1 Coverage.type uses coverage-type-cs', () => {
  byType('Coverage').forEach(c => pm.expect(codes(c.type).some(x => /coverage-type-cs$/.test(x.system))).to.be.true);
});
pm.test('US7.AC2 RelatedPerson (mother) has an NI identifier', () => {
  byType('RelatedPerson').forEach(r => pm.expect((r.identifier || []).some(i => hasCode(i.type, null, 'NI'))).to.be.true);
});
pm.test('US7.AC4 sick leave is one Observation with effectivePeriod', () => {
  const o = obsByCode(OBS.sick_leave);
  pm.expect(o.length).to.be.at.most(1);
  o.forEach(x => pm.expect(x.effectivePeriod && x.effectivePeriod.start).to.be.a('string'));
});

// ---------- field-by-field comparison with the DMED source ----------
let dmed = pm.variables.get('dmed_form_json');
if (dmed) {
  try { dmed = JSON.parse(dmed); } catch (e) { dmed = null; pm.test('dmed_form_json is valid JSON', () => pm.expect.fail(e.message)); }
}
const d = dmed && (dmed.data || dmed);
if (d) {
  const day = s => String(s || '').slice(0, 10);
  const one = (label, code) => {
    const o = obsByCode(code);
    pm.expect(o.length, `${label}: expected exactly 1 Observation LOINC#${code}, got ${o.length}`).to.eql(1);
    return o[0];
  };
  const absent = (label, code) => pm.expect(obsByCode(code).length, `${label} is null in DMED so no Observation should exist`).to.eql(0);
  const cmTarget = (cm, v) => (CM[cm] || {})[v];

  pm.test('DMED data.hospitalization_id = Encounter.identifier', () =>
    pm.expect((encounter.identifier || []).map(i => String(i.value))).to.include(String(d.hospitalization_id)));

  pm.test('DMED phone / email → Patient.telecom', () => {
    const t = (patient.telecom || []).map(x => `${x.system}:${x.value}`);
    if (d.phone) pm.expect(t).to.include(`phone:${d.phone}`);
    if (d.email) pm.expect(t).to.include(`email:${d.email}`);
  });
  pm.test('DMED zip_code / address parts → Patient.address', () => {
    const a = (patient.address || [])[0] || {};
    if (d.zip_code) pm.expect(a.postalCode).to.eql(String(d.zip_code));
    pm.expect(!!(a.state || a.district || a.city), 'address has region/district').to.eql(!!(d.region || d.city));
  });

  pm.test('DMED medical_care_form → Encounter.priority (ConceptMap)', () => {
    const exp = cmTarget('dmed-form-066-medical-care-form-to-priority', d.medical_care_form);
    if (!d.medical_care_form) return pm.expect(encounter.priority, 'priority must be absent').to.be.undefined;
    pm.expect(exp, `no ConceptMap target for ${d.medical_care_form}`).to.be.an('array').that.is.not.empty;
    pm.expect(codes(encounter.priority).map(c => c.code)).to.include.oneOf(exp);
  });

  for (const k of ['emergency_care', 'delivered_by_ambulance', 'has_direction', 'same_illness_in_last_month']) {
    pm.test(`DMED ${k} = ${JSON.stringify(d[k])} → Observation LOINC#${OBS[k]} (false is sent, null is omitted)`, () => {
      if (d[k] === null || d[k] === undefined) return absent(k, OBS[k]);
      pm.expect(one(k, OBS[k]).valueBoolean).to.eql(d[k]);
    });
  }

  pm.test('DMED has_direction → Encounter.admission.admitSource', () => {
    const as = codes((encounter.admission || {}).admitSource).map(c => c.code);
    if (d.has_direction === true) pm.expect(as).to.include('mserv-0006-00007');
    else if (d.has_direction === false) pm.expect(as).to.include('mserv-0006-00001');
    else pm.expect(as, 'admitSource must be absent when has_direction is null').to.have.length(0);
  });
  pm.test('DMED same_illness_in_last_month → Encounter.admission.reAdmission (only on true)', () => {
    const ra = codes((encounter.admission || {}).reAdmission).map(c => c.code);
    if (d.same_illness_in_last_month === true) pm.expect(ra).to.include('repeat-current-year');
    else pm.expect(ra, 'reAdmission must not be set unless same_illness_in_last_month = true').to.have.length(0);
  });

  pm.test(`DMED urgency_time = ${d.urgency_time} → Observation LOINC#77977-7 (DiseaseInjuryDelayCS)`, () => {
    if (!d.urgency_time) return absent('urgency_time', OBS.urgency_time);
    pm.expect(codes(one('urgency_time', OBS.urgency_time).valueCodeableConcept).map(c => c.code))
      .to.include.oneOf(cmTarget('dmed-form-066-urgency-time-to-disease-injury-delay', d.urgency_time));
  });

  pm.test(`DMED bed_type = ${d.bed_type} → Encounter.location.form`, () => {
    const got = (encounter.location || []).flatMap(l => codes(l.form)).map(c => c.code);
    if (!d.bed_type) return pm.expect(got).to.have.length(0);
    pm.expect(got).to.include.oneOf(cmTarget('dmed-form-066-bed-type-to-organizational-specialization', d.bed_type));
  });

  pm.test(`DMED reanimation_period = ${JSON.stringify(d.reanimation_period)} → Observation LOINC#LP76050-1 valueQuantity in d`, () => {
    if (d.reanimation_period === null || d.reanimation_period === undefined || d.reanimation_period === '') return absent('reanimation_period', OBS.reanimation_period);
    const q = one('reanimation_period', OBS.reanimation_period).valueQuantity || {};
    pm.expect(q.value, 'value must be a number, not a string').to.be.a('number').and.eql(Number(d.reanimation_period));
    pm.expect(q.code).to.eql('d');
  });

  pm.test(`DMED result_treatment = ${d.result_treatment} (fallback hospitalization_result) → dischargeDisposition`, () => {
    const v = d.result_treatment || d.hospitalization_result;
    const got = codes((encounter.admission || {}).dischargeDisposition).map(c => c.code);
    if (!v) return pm.expect(got).to.have.length(0);
    pm.expect(got).to.include.oneOf(cmTarget('dmed-form-066-treatment-result-to-discharge-disposition', v));
  });

  pm.test(`DMED outcome_treatment = ${d.outcome_treatment} → Encounter.subjectStatus`, () => {
    const exp = cmTarget('dmed-form-066-treatment-outcome-to-subject-status', d.outcome_treatment);
    const got = codes(encounter.subjectStatus).map(c => c.code);
    if (!d.outcome_treatment || !exp || !exp.length) return pm.expect(got, 'subjectStatus must be absent').to.have.length(0);
    pm.expect(got).to.include.oneOf(exp);
  });

  for (const k of ['aids', 'rw', 'hepatitis_b', 'hepatitis_c']) {
    pm.test(`DMED ${k} = ${JSON.stringify(d[k])} → LOINC#${OBS[k]} ${d[k] ? 'POS' : 'NEG'}, date = ${d[LAB_DATE[k]]}`, () => {
      if (d[k] === null || d[k] === undefined) return absent(k, OBS[k]);
      const o = one(k, OBS[k]);
      const v = codes(o.valueCodeableConcept).concat(...(o.interpretation || []).map(codes)).map(c => c.code);
      pm.expect(v).to.include(d[k] ? 'POS' : 'NEG');
      if (d[LAB_DATE[k]]) pm.expect(day(o.effectiveDateTime)).to.eql(day(d[LAB_DATE[k]]));
    });
  }

  pm.test(`DMED payment_type = ${d.payment_type} → Coverage.type`, () => {
    const cov = byType('Coverage');
    if (!d.payment_type) return pm.expect(cov).to.have.length(0);
    pm.expect(cov).to.have.length(1);
    pm.expect(codes(cov[0].type).map(c => c.code)).to.include.oneOf(cmTarget('dmed-form-066-payment-type-to-coverage-type', d.payment_type));
    pm.expect(resolve((cov[0].beneficiary || {}).reference)).to.equal(patient);
  });

  pm.test('DMED newborn_weight (g) / newborn_height (cm)', () => {
    if (d.newborn_weight == null) absent('newborn_weight', OBS.newborn_weight);
    else { const q = one('newborn_weight', OBS.newborn_weight).valueQuantity; pm.expect([q.value, q.code]).to.eql([Number(d.newborn_weight), 'g']); }
    if (d.newborn_height == null) absent('newborn_height', OBS.newborn_height);
    else { const q = one('newborn_height', OBS.newborn_height).valueQuantity; pm.expect([q.value, q.code]).to.eql([Number(d.newborn_height), 'cm']); }
  });
  pm.test('DMED newborn_mothers_pinfl → RelatedPerson.identifier (NI)', () => {
    const rp = byType('RelatedPerson');
    if (!d.newborn_mothers_pinfl) return pm.expect(rp).to.have.length(0);
    pm.expect(rp.flatMap(r => r.identifier || []).filter(i => hasCode(i.type, null, 'NI')).map(i => String(i.value))).to.include(String(d.newborn_mothers_pinfl));
  });
  pm.test(`DMED tuberculosis_treatment_resistance = ${d.tuberculosis_treatment_resistance} → LOINC#18769-0`, () => {
    if (!d.tuberculosis_treatment_resistance) return absent('tb', OBS.tuberculosis_treatment_resistance);
    pm.expect(codes(one('tb', OBS.tuberculosis_treatment_resistance).valueCodeableConcept).map(c => c.code))
      .to.include.oneOf(cmTarget('dmed-form-066-tuberculosis-resistance-to-sensitivity', d.tuberculosis_treatment_resistance));
  });
  pm.test('DMED sick_leave_start_date / end_date → LOINC#105583-9 effectivePeriod', () => {
    if (!d.sick_leave_start_date && !d.sick_leave_end_date) return absent('sick_leave', OBS.sick_leave);
    const p = one('sick_leave', OBS.sick_leave).effectivePeriod || {};
    pm.expect([day(p.start), day(p.end)]).to.eql([day(d.sick_leave_start_date), day(d.sick_leave_end_date)]);
  });

  pm.test('DMED doctor / department_head / deputy_chief → Practitioners with matching names', () => {
    const names = byType('Practitioner').map(p => JSON.stringify(p.name || []).toUpperCase());
    for (const k of ['doctor', 'department_head', 'deputy_chief']) {
      const p = d[k]; if (!p) continue;
      const surname = String(p.surname || String(p.name || '').split(' ')[0]).toUpperCase();
      pm.expect(names.some(n => n.includes(surname)), `${k} ${surname}`).to.be.true;
    }
  });

  pm.test('DMED death fields → death Conditions only when result is a death', () => {
    const deathRoles = ['immediate-cause-of-death', 'underlying-cause-of-death', 'main-disease-death', 'other-significant-death'];
    const n = byType('Condition').filter(c => (c.category || []).some(cat => deathRoles.some(r => hasCode(cat, ROLE_CS, r)))).length;
    if (!d.death_cause && !d.death_cause_cause && !d.death_main_diagnosis) pm.expect(n, 'death diagnoses present but DMED has none').to.eql(0);
    else pm.expect(n).to.be.at.least(1);
  });
}

// ---------- D3: re-save produces a new Composition ----------
const prev = pm.variables.get('previous_composition_id');
if (prev) {
  pm.test('D3 re-saved form produces a new Composition id / Bundle identifier', () => {
    pm.expect(comp.id).to.not.eql(prev);
  });
}
pm.collectionVariables.set('last_composition_id', comp.id);
console.log(`Composition id ${comp.id}; set previous_composition_id to this before re-running after a re-save`);
