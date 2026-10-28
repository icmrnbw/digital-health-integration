See the [Form 096 field mapping](form-096-mapping.html) and [complete document example](Bundle-example-form-096-maternity-medical-record.html).

All clinical sections are optional (0..1); omit sections and resources whose source facts are absent.
Do not synthesize zeroes, negative assertions, Apgar components, or a five-minute score. Incoming DMED Apgar is the one-minute total (LOINC 9272-6).
Composition.author and the mandatory FHIR/Core document metadata remain required. A missing clinical section does not remove author requirements.
Use exact, documented canonical Coding.system URIs. A CodeSystem defined in an open PR is not automatically approved or deployed.
Missing machine codes can retain trustworthy source text where the profile permits it; do not substitute a merely similar international concept.
Birth outcome uses LOINC 63893-2 with SNOMED CT 281050002 Livebirth or 237364002 Stillbirth. Death after livebirth is a separate fact.
When the period of fetal death is known, add a Condition for the same child: 237361005 for antepartum or 237362003 for intrapartum death.
Use Patient.deceasedBoolean=true when death is known without an exact date; use deceasedDateTime only when available.
Historical pregnancy totals must not be computed from the current delivery. Omit unavailable historical counts.
Preserve the mother and maternal encounter on common delivery facts shared between 096 and 097; use stable source-derived business identifiers.
The snapshot inside each document is historical. Posting a document alone does not establish an upsert of a standalone master Encounter.

Use UZ Core Encounter for the maternal hospitalization shared with Form 066; discharge disposition and custodian are optional. Pelvimetry is represented by six separate maternal Observations; diagonal conjugate uses SNOMED CT 249011002. The anatomical meaning of C. vera must not be silently narrowed. Epidemiological history is an optional open section without a fixed coded discriminator.

If a source author is identified but the position or role is unavailable, Composition.author may reference UZCorePractitioner directly. Do not invent a PractitionerRole or profession.
