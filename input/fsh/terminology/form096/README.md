# Form 096 terminology

Source of truth: [Form 096 Google Sheet](https://docs.google.com/spreadsheets/d/1zX3HmGvyh3_eY0aMbyhoGozrTIC6pXqo5IbSMMSX-Eo), worksheet `ValueSets`.

The checked snapshot contains 149 terminology rows, represented here as:

- 35 ValueSet resources from the worksheet;
- 22 governed local CodeSystem resources in the `https://terminology.dhp.uz/fhir/chr` namespace;
- one additional Form 096 hospitalization-outcome ValueSet needed for the runtime `hospitalization_outcome` field (`discharged`, `transferred`, `died`).

International LOINC and SNOMED CT concepts are included directly in the ValueSets. Local concepts retain the exact current Google Sheet codes, including the four-digit suffix format such as `chr-0083-0001`.

`Form096GoogleTerminology.manifest.json` records the source URL, artifact counts, and local concept counts used for reconciliation.
