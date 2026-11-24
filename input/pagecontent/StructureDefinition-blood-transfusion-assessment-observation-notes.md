### Quick Start {#quick-start}

Common API interactions for this profile. It is built on Observation, so use the Observation endpoint. Requests require a JWT access token - see [Security and authentication](https://dhp.uz/fhir/core/en/api-access.html#security). `[base]` is the [FHIR server base URL](https://dhp.uz/fhir/core/en/api-access.html#endpoints); `|` separates a system from its value and must be URL-encoded as `%7C`.

**Read by server id**

```
GET [base]/Observation/[id]
```

**Find transfusion assessments** (by recipient, blood unit, encounter, incompatible result)

```
GET [base]/Observation?patient=Patient/[id]&code=http://snomed.info/sct%7C252314007
GET [base]/Observation?focus=BiologicallyDerivedProduct/[id]
GET [base]/Observation?encounter=Encounter/[id]&code=http://snomed.info/sct%7C252314007
GET [base]/Observation?code=http://snomed.info/sct%7C252314007&component-value-concept=http://snomed.info/sct%7C250406009
```

**Create**

```
POST [base]/Observation
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": { "coding": [ { "system": "http://snomed.info/sct", "code": "252314007" } ] },
  "subject": { "reference": "Patient/[id]" },
  "focus": [ { "reference": "BiologicallyDerivedProduct/[id]" } ],
  "effectiveDateTime": "2026-11-11T10:30:00+05:00",
  ...
}
```

**Correct an error** - PUT the full resource back with the corrected value and `status` set to `amended`, keeping the original `effectiveDateTime`:

```
PUT [base]/Observation/[id]
If-Match: W/"3"   # the ETag from your last read; 412 if it changed since
```

See the [CapabilityStatement](https://dhp.uz/fhir/core/en/CapabilityStatement-DHPCapabilityStatement.html#Observation1-9) for the full list of supported search parameters.

### Related

- [Blood Service](blood-service.html) &middot; [Blood service forms](forms-volume-08-blood-service.html)
- [UZ Core Observation](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-observation.html) &middot; [UZ Core BiologicallyDerivedProduct](https://dhp.uz/fhir/core/en/StructureDefinition-uz-core-biologically-derived-product.html)
- [Must Support](https://dhp.uz/fhir/core/en/must-support.html) &middot; [General guidance](https://dhp.uz/fhir/core/en/general-guidance.html)
