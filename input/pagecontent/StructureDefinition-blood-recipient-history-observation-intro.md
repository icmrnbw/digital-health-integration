Blood Recipient History Observation records one part of the history taken from a recipient before a blood transfusion: the transfusion history or the obstetric history. The `code` says which, and the value comes from the matching value set. The [Blood Transfusion Assessment Observation](StructureDefinition-blood-transfusion-assessment-observation.html) for a unit lists the history it relied on in `derivedFrom`. It is built on [UZ Core Observation](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-observation.html), so it is read and searched through the Observation endpoint. The subject is the recipient, a [UZ Core Patient](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-patient.html). See [Blood Service](blood-service.html) for how it fits with the UZ Core profiles across the blood service, from donor registration to transfusion.

### Mandatory and Must Support data elements

The elements below must always be present (mandatory) or must be supported when the data is available ([Must Support](https://dhp.uz/fhir/core/en/must-support.html)) - not all are required, but your system must populate each Must Support element when it has the data and process it on receipt. This is the human-readable summary; the [formal views](#profile) below give the exact cardinalities, types, and terminology bindings.

#### Each Blood Recipient History Observation Must Have

Every Blood Recipient History Observation must carry a status, a code - *transfusion history* or *obstetric history* - and a subject - the recipient [Patient](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-patient.html) (1..1). It has no components.

#### Each Blood Recipient History Observation Must Support

- the history category (`valueCodeableConcept`), from the value set that matches the code;
- the reason there is no value (`dataAbsentReason`);
- the encounter and the performer - the practitioner who took the history;
- when the history was taken (`effective[x]`);
- the other Must Support elements inherited from UZ Core Observation.

| `code` | `valueCodeableConcept` from |
|---|---|
| `bldcomp-0001-00003` (transfusion history) | [Blood transfusion history category](ValueSet-blood-transfusion-history-vs.html) |
| `bldcomp-0001-00004` (obstetric history) | [Blood recipient obstetric history category](ValueSet-blood-recipient-obstetric-history-vs.html) |

When a history does not apply, such as an obstetric history for a man, send `dataAbsentReason` `not-applicable` instead of a value. When it could not be found out, send `unknown`.

### Building the JSON, step by step

The examples below show a transfusion history and an obstetric history that does not apply. Copy one and adapt it - every value shown validates against this profile. The complete reference instances are the [transfusion history](Observation-example-blood-recipient-transfusion-history.html) and the [obstetric history](Observation-example-blood-recipient-obstetric-history.html).

#### A transfusion history

The codes come from the [blood transfusion assessment codes](CodeSystem-blood-transfusion-assessment-cs.html) and the [blood transfusion history categories](CodeSystem-blood-transfusion-history-cs.html):

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00003",
        "display": "Transfuzion anamnez"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "valueCodeableConcept": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-history-cs",
        "code": "bldcomp-0003-00001",
        "display": "Avval qon quyilmagan"
      }
    ]
  }
}
```

#### An obstetric history that does not apply

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00004",
        "display": "Akusherlik anamnezi"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "dataAbsentReason": {
    "coding": [ { "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason", "code": "not-applicable" } ]
  }
}
```

For example API calls, see the [Quick Start](#quick-start) at the bottom of this page.
