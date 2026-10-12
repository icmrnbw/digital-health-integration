# Screening plans and invitations

A patient-specific plan uses the existing [UZ Core ServiceRequest](https://dhp.uz/fhir/core/StructureDefinition-uz-core-servicerequest.html) with `intent = plan`, category SNOMED CT `310422005` (Prevention/screening invitation), and exactly one program identifier under `https://dhp.uz/fhir/core/sid/prg/uz/program`. The clinical-order [ScreeningServiceRequest](StructureDefinition-screening-service-request.html) retains its MIS source metadata contract.

A national invitation carries exactly one `instantiatesCanonical = canonical|version` of its [UZ Core PlanDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-plan-definition.html). An independent MIS plan has no `instantiatesCanonical`. Recognize the plan by intent, category and program identifier before applying this origin rule; URL shape does not determine origin. Both kinds use UZ Core ServiceRequest and omit `meta.source` and `occurrencePeriod`. `subject` references the patient; `authoredOn` and at least one assigned `performer` are required by this application contract. Optional clinical coding is in `code.concept`, not `code.reference`. Clinical evidence retains its source metadata. A 365-day reminder is not a plan occurrence period.

`code` is optional. When sent it is clinical coding in `code.concept`; it is not the lookup key for the program. `performer` identifies an assigned service provider. The application's program-to-system mapping sends DMED programs to DMED and HPV programs to the HPV system, independently of who created the plan.

## Program registry and definitions

Load [Screening Program Types](https://dhp.uz/fhir/core/ValueSet-screening-program-type-vs.html) from the released Core package and expand it with designations. It enumerates the eight screening SNOMED CT codes and the retained national `screening-code-cs` codes, including home visit codes; it is not restricted to the nine DMED questionnaires. SNOMED translations come from `screening-sct-cs`, local translations from `screening-code-cs`. The identifier value is the code, while the identifier system remains the `prg` namespace, not the clinical CodeSystem URL.

| Program | Program identifier value | Implementing system |
|---|---|---|
| IHD screening | `171223006` | DMED |
| Fertility assessment | `408961002` | DMED |
| Cerebrovascular screening | `mserv-0007-00003` | DMED |
| Intestinal helminthiasis screening | `171147008` | DMED |
| Cardiovascular risk screening | `300007000` | DMED |
| Diabetes screening | `171183004` | DMED |
| Breast questionnaire program | `mserv-0007-00007` | DMED |
| Hematological screening | `762445000` | DMED |
| Cervical questionnaire program | `mserv-0007-00009` | DMED |
| Breast screening program | `268547008` | HPV |
| Cervical screening program | `171149006` | HPV |

DMED breast/cervical questionnaire clinical codes remain SNOMED CT; their **program identifiers** are distinct local codes. Matching clinical codes or translated names does not make programs equivalent. `breast-cervical-unspecified` remains a historical/evidence classification, not a plan program.

Screening definitions reuse [UZ Core PlanDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-plan-definition.html) and [UZ Core ActivityDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-activitydefinition.html). The application requires their canonical URL, immutable version and the same program identifier as the patient plan. Set PlanDefinition.useContext[screeningFocus] to SNOMED CT `360156006`, and use the same screening focus in ActivityDefinition.useContext. Program identifiers supplement stable record identifiers; Questionnaire.useContext with code `program` remains the separate integration-area classification.

`PlanDefinition.action.definitionCanonical` pins the invitation ActivityDefinition canonical and version. [The invitation activity example](ActivityDefinition-example-hpv-cervical-invitation-activity.html) uses `kind = ServiceRequest`, `intent = plan` and `profile = UZCoreServiceRequest`. The application creates one invitation per patient/program and applicable definition, supplying patient, category, identifiers and the exact PlanDefinition reference. Questionnaire/Observation definitions are not completion requirements in this invitation template; the MIS uses its existing clinical integration contract. DHP does not infer completion from results. These screening rules are application validation requirements, not constraints imposed by a new profile; validation against Core alone does not prove this contract.

## Find and reuse a plan

```http
GET [base]/ServiceRequest?subject=Patient/{id}&intent=plan&status=draft,active&category=http://snomed.info/sct|310422005&identifier=https://dhp.uz/fhir/core/sid/prg/uz/program|{programCode}
```

URL-encode parameter values in an actual request. Do not use category `20135006`, a code-only match or legacy prefixes to recognize a plan. `20135006` remains usable for clinical screening/home visit orders in Core; it is not the invitation category.

For a national invitation, compare the exact `canonical|version` with the current program definition before reuse. An open invitation for an older version must not block an invitation for the current version. Resolve all candidates: zero current candidates permits creation, one permits reuse, and several are a conflict requiring resolution. Never select an arbitrary first result. The application must test its server's `instantiates-canonical` search and include the current version in atomic creation/uniqueness criteria. An unqualified find-or-create against all open versions would let an old invitation block a new one.

Search followed by unconditional POST is not atomic. Use supported conditional create or a server-side uniqueness mechanism with the full agreed identity, and treat multiple matches as an error. Use version-aware updates (`If-Match`) when activating or closing a plan. Do not replace identifiers or origin fields on an existing invitation.

## Repeated screenings and status

The HPV plan is reused across repeated screenings for the patient/program while the definition and eligibility remain applicable. Recurrence does not itself create a new invitation. Record every round through new clinical orders and results, keeping their links to the same plan and to the immediate order. Result timestamps and order links distinguish performances; no new cycle identifier is invented here.

MIS systems own plan status changes. HPV activates an invitation and does not complete it after an individual screening round. DMED sets its own plan to `completed` after saving the linked `QuestionnaireResponse`. A completed DMED plan is historical; the provided contract does not specify whether a later DMED questionnaire creates another plan, so this must be agreed before adding automatic recurrence behavior. Neither system closes a plan belonging to the other program.

Exit from the cohort or a replacement PlanDefinition ends applicability of the old plan. **Proposed closure mapping, pending agreement:** `completed` on cohort exit; `revoked` on exclusion or definition replacement. A successor references its predecessor through `ServiceRequest.replaces`; historical evidence retains its original `basedOn`. If used, the optional standard `request-statusReason` extension may carry a code from the draft [closure reason ValueSet](ValueSet-screening-plan-closure-reason-vs.html). Draft reason codes and status mappings are not mandatory production rules.

FHIR defines `completed` as full performance of the implied request. Cohort exit with unperformed work therefore requires explicit agreement on semantics; `revoked` is an alternative to consider. Do not enforce the proposed cohort-exit transition until that decision is made. Consent/refusal and exclusion are distinct decisions; a missing Consent resource is not a refusal.

## Results and compatibility

Composition is optional legacy evidence. HPV may continue to submit Composition against the retained [ScreeningComposition](StructureDefinition-screening-composition.html) profile, whose canonical, structural constraints and existing examples remain available. Its retired publication status does not add a payload prohibition; this contract does not reject otherwise valid legacy Composition solely because of that status. New screening flows do not require Composition or use it to decide plan completion. Read individual results by the exact program identifier or explicit plan/order links; preserve existing documents for historical access.

Preserve immediate-order references alongside the plan link. Core Observation allows `basedOn` 0..*, pathology ServiceRequest requires 1..*, and immunohistochemistry Observation permits multiple links. Wait for the compatible Core release on the server before sending payloads relying on the widened cardinalities.

The historical namespace `https://dhp.uz/fhir/core/sid/uz/screening-program-type` is deprecated for new writes. Keep old records readable in an explicit migration/read compatibility path; do not use it to recognize new plans, and do not add it as an alias to new resources. The current NamingSystem canonical is retained. Clinical orders keep their existing profile and `meta.source` contract. Definitions reuse the existing Core profiles. Screening focus and the additional plan rules are checked by the application contract.

## Decisions and release prerequisites

The Ministry must approve age cohort boundaries, evaluation date and inclusive/exclusive rules, consent purpose and legal basis, refusal scope and duration, closure mappings, and successor behavior. The generic Group and data-sharing Consent profiles are not automatically a screening enrollment contract. Patient result visibility is a separate product decision.

Core 0.11.0 is already published but omits ServiceRequest from the required ActivityDefinition.kind ValueSet. Publish and register the updated Core 0.11.1 package before releasing Integrations with the invitation template, program registry, distinct DMED identifiers and cardinality fixes. Applications must load both compatible packages in fhir.lock. Source preparation and local validation do not publish packages or deploy server validation rules.

Vaccination calendars are found by `PlanDefinition?context-type-value=focus$http://snomed.info/sct|33879002`. A definition with no focus is not classified as vaccination. Regional context uses the Core `states-cs` codes.

Sources: the agreed 9 October 2026 audit response, [FHIR R5 ServiceRequest](https://hl7.org/fhir/R5/servicerequest.html), and the [request-statusReason extension](https://hl7.org/fhir/extensions/StructureDefinition-request-statusReason.html).
