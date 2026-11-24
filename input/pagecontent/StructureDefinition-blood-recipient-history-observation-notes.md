### Quick Start {#quick-start}

Common API interactions for this profile. It is built on Observation, so use the Observation endpoint. Requests require a JWT access token - see [Security and authentication](https://dhp.uz/fhir/core/en/api-access.html#security). `[base]` is the [FHIR server base URL](https://dhp.uz/fhir/core/en/api-access.html#endpoints); `|` separates a system from its value and must be URL-encoded as `%7C`.

**Read by server id**

```
GET [base]/Observation/[id]
```

**Find a recipient's transfusion or obstetric history**

```
GET [base]/Observation?patient=Patient/[id]&code=https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs%7Cbldcomp-0001-00003
GET [base]/Observation?patient=Patient/[id]&code=https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs%7Cbldcomp-0001-00004
```

**Create**

```
POST [base]/Observation
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00003"
      }
    ]
  },
  "subject": { "reference": "Patient/[id]" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  ...
}
```

**Correct an error** - PUT the full resource back with the corrected value and `status` set to `amended`:

```
PUT [base]/Observation/[id]
If-Match: W/"3"   # the ETag from your last read; 412 if it changed since
```

See the [CapabilityStatement](https://dhp.uz/fhir/core/en/CapabilityStatement-DHPCapabilityStatement.html#Observation1-9) for the full list of supported search parameters.

### Related

- [Blood Service](blood-service.html) &middot; [Blood service forms](forms-volume-08-blood-service.html)
- [UZ Core Observation](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-observation.html)
- [Must Support](https://dhp.uz/fhir/core/en/must-support.html) &middot; [General guidance](https://dhp.uz/fhir/core/en/general-guidance.html)
