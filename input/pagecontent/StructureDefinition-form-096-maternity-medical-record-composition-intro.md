The eight required sections remain mandatory (`1..1`). The clinical sections
`medicalAndObstetricHistory`, `currentPregnancy`, `obstetricExamination`,
`laborCourse`, `newbornDeliveryRecord`, and `postpartumPeriod` allow zero or more
entries (`0..*`). If any of these sections has no entries, it must provide both
`section.emptyReason` and explanatory `section.text` (invariant
`form096-empty-section`). The section title and code remain required.

Use the explanation to distinguish an inapplicable section (for example, labor
and newborn information for an admission that ended without delivery) from
information unavailable in the source system (for example, postpartum
observations not yet recorded in DMED). Missing information must not be
interpreted as a normal examination or the confirmed absence of complications.
Do not create placeholder clinical resources to satisfy section cardinality.

A section containing entries must not also carry `emptyReason`, as required by
the inherited FHIR constraint `cmp-2`. Empty sections still need narrative text
to satisfy `cmp-1`; `emptyReason` alone is insufficient.

The `admissionInformation` and `responsiblePersons` sections still require at
least one entry. `Composition.author` remains mandatory and `Composition.status`
remains fixed to `final`. These structural rules do not replace the source
system's checks that a form is ready for official exchange.
