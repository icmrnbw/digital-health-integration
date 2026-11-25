Blood Transfusion Assessment Observation records the compatibility tests made between a recipient and one blood unit: ABO compatibility, Rh-Hr compatibility and the biological compatibility test at the start of the transfusion, each in its own component. Record one Observation per unit, and point `focus` to the unit's [BiologicallyDerivedProduct](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-biologically-derived-product.html) when it is known. The history taken from the recipient goes in a [Blood Recipient History Observation](StructureDefinition-blood-recipient-history-observation.html), and the preliminary ABO group in a [UZ Core Observation](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-observation.html) with LOINC `883-9`; the assessment lists both in `derivedFrom`. It is built on [UZ Core Observation](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-observation.html), so it is read and searched through the Observation endpoint. The subject is the recipient, a [UZ Core Patient](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-patient.html), and the record can link to the [Encounter](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-encounter.html) of the transfusion and to the practitioner who made the tests. See [Blood Service](blood-service.html) for how it fits with the UZ Core profiles across the blood service, from donor registration to transfusion.

### Mandatory and Must Support data elements

The elements below must always be present (mandatory) or must be supported when the data is available ([Must Support](https://dhp.uz/fhir/core/en/must-support.html)) - not all are required, but your system must populate each Must Support element when it has the data and process it on receipt. This is the human-readable summary; the [formal views](#profile) below give the exact cardinalities, types, and terminology bindings.

#### Each Blood Transfusion Assessment Observation Must Have

Every Blood Transfusion Assessment Observation must carry a status, a code - always SNOMED CT `252314007` *Blood transfusion test* - and a subject - the recipient [Patient](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-patient.html) (1..1). It has no `value`: the test results go in components.

#### Each Blood Transfusion Assessment Observation Must Support

- the business identifier of the assessment;
- the blood unit tested (`focus`);
- the encounter of the transfusion and the performer - the practitioner, practitioner role or organization responsible for the tests;
- when the tests were made (`effective[x]`) and when the result was issued (`issued`);
- the ABO compatibility and Rh-Hr compatibility results, each in its own component;
- the result of the biological compatibility test in its own component;
- the other Must Support elements inherited from UZ Core Observation, including `derivedFrom`.

### Building the JSON, step by step

The examples below go from the smallest instance the server will accept to a complete assessment. Copy one and adapt it - every value shown validates against this profile. The complete reference instance is the [assessment of a red cell unit](Observation-example-blood-transfusion-assessment.html).

#### The smallest observation you should send

Three elements are required: the `status`, the `code` saying this is a blood transfusion test, and the `subject` (the recipient [Patient](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-patient.html)). Add the `effectiveDateTime` of the tests as well, since a result without a time cannot be placed against the transfusion:

```json
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:30:00+05:00"
}
```

The `subject` is a plain `Reference`, so the target sits directly under `reference`.

#### A complete assessment

Each test goes in its own `component` slice. Every slice is optional and occurs at most once; the `code` selects the slice, and the `valueCodeableConcept` must come from that slice's value set:

| Slice | `code` | `valueCodeableConcept` from |
|---|---|---|
| `aboCompatibility` | `bldcomp-0001-00001` | [Blood compatibility result](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `rhHrCompatibility` | `bldcomp-0001-00002` | [Blood compatibility result](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `biologicalTest` | `bldcomp-0001-00006` | [Positive / negative result](ValueSet-positive-negative-result-vs.html) (SNOMED CT) |

The component codes come from the [blood transfusion assessment codes](CodeSystem-blood-transfusion-assessment-cs.html):

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "encounter": { "reference": "Encounter/example-transfusion-assessment-encounter" },
  "focus": [ { "reference": "BiologicallyDerivedProduct/example-blood-component-product" } ],
  "effectiveDateTime": "2026-11-11T10:30:00+05:00",
  "issued": "2026-11-11T10:35:00+05:00",
  "performer": [ { "reference": "Practitioner/example-transfusion-assessment-practitioner" } ],
  "derivedFrom": [
    { "reference": "Observation/example-blood-recipient-transfusion-history" },
    { "reference": "Observation/example-blood-recipient-blood-group" }
  ],
  "component": [
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00001",
            "display": "ABO bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00002",
            "display": "Rh-Hr bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00006",
            "display": "Biologik sinama"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "260385009", "display": "Negative" } ]
      }
    }
  ]
}
```

For example API calls, see the [Quick Start](#quick-start) at the bottom of this page.
