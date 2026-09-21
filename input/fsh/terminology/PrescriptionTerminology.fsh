CodeSystem: PrescriptionTypeCS
Id: prescription-type-cs
Title: "Prescription Type Codes"
Description: "Types of electronic prescriptions exchanged by the DMED Prescription integration. The codes match the A and R prefixes shown to users."
* ^url = $prescription-type-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "Uzinfocom"
* #A "Ordinary prescription" "An ordinary paid electronic prescription."
  * ^designation[0].language = #ru
  * ^designation[=].value = "Обычный рецепт"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Oddiy retsept"
* #R "Reimbursement prescription" "A prescription reimbursed under the State Health Insurance Fund programme."
  * ^designation[0].language = #ru
  * ^designation[=].value = "Реимбурсационный рецепт"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Reimbursatsiya retsepti"

ValueSet: PrescriptionTypeVS
Id: prescription-type-vs
Title: "Prescription Types"
Description: "Allowed prescription types for the DMED Prescription integration."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/prescription-type-vs"
* ^status = #active
* ^experimental = false
* include codes from system PrescriptionTypeCS

CodeSystem: PrescriptionWorkflowActionCS
Id: prescription-workflow-action-cs
Title: "Prescription Workflow Action Codes"
Description: "Actions performed during the prescription signing, approval, revision and cancellation workflow."
* ^url = $prescription-workflow-action-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "Uzinfocom"
* #create "Create prescription"
* #sign "Sign prescription"
* #send-for-confirmation "Send for confirmation"
* #approve "Approve prescription"
* #request-revision "Request revision"
* #update "Update prescription"
* #renew "Renew prescription"
* #cancel "Cancel prescription"
* #dispense "Dispense medication"
* #administer "Administer medication"

ValueSet: PrescriptionWorkflowActionVS
Id: prescription-workflow-action-vs
Title: "Prescription Workflow Actions"
Description: "Allowed actions in the DMED Prescription workflow."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/prescription-workflow-action-vs"
* ^status = #active
* ^experimental = false
* include codes from system PrescriptionWorkflowActionCS

CodeSystem: PrescriptionWorkflowStatusCS
Id: prescription-workflow-status-cs
Title: "Prescription Workflow Business Status Codes"
Description: "Business statuses kept separate from the clinical MedicationRequest.status."
* ^url = $prescription-workflow-status-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "Uzinfocom"
* #not-signed "Not signed"
* #review-pending "Awaiting reviewer confirmation"
* #approved "Approved"
* #revision-requested "Revision requested"
* #cancelled "Cancelled"

ValueSet: PrescriptionWorkflowStatusVS
Id: prescription-workflow-status-vs
Title: "Prescription Workflow Business Statuses"
Description: "Allowed business statuses for a prescription approval Task."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/prescription-workflow-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system PrescriptionWorkflowStatusCS

CodeSystem: PrescriptionErrorCS
Id: prescription-error-cs
Title: "Prescription Integration Error Codes"
Description: "Stable prescription-specific error codes used in OperationOutcome.issue.details.coding."
* ^url = $prescription-error-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "Uzinfocom"
* #terminology-crosswalk-not-found "Terminology crosswalk not found"
* #reimbursement-eligibility-failed "Reimbursement eligibility failed"
* #reimbursement-duration-invalid "Reimbursement duration is not a multiple of 30 days"
* #reimbursement-inn-limit-exceeded "Reimbursement INN limit exceeded"
* #reimbursement-repeat-too-soon "Another reimbursement prescription for this INN exists in the previous 30 days"
* #reimbursement-partial-dispense-forbidden "Partial reimbursement dispense is forbidden"
* #ordinary-validity-exceeded "Ordinary prescription validity exceeds 90 days"
* #review-required "Reviewer approval is required"
* #quantity-exceeds-prescribed "Dispensed quantity exceeds the prescribed quantity"
* #version-conflict "Resource version conflict"

ValueSet: PrescriptionErrorVS
Id: prescription-error-vs
Title: "Prescription Integration Errors"
Description: "Allowed prescription-specific error codes."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/prescription-error-vs"
* ^status = #active
* ^experimental = false
* include codes from system PrescriptionErrorCS

CodeSystem: DMEDPrescriptionTypeCS
Id: dmed-prescription-type-cs
Title: "DMED Prescription API Type Codes"
Description: "Source codes used by the DMED prescriptions API."
* ^url = $dmed-prescription-type-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #simple "Ordinary"
* #reimbursement "Reimbursement"

ValueSet: DMEDPrescriptionTypeVS
Id: dmed-prescription-type-vs
Title: "DMED Prescription API Types"
Description: "Source prescription types used by DMED."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/dmed-prescription-type-vs"
* ^status = #active
* ^experimental = false
* include codes from system DMEDPrescriptionTypeCS

CodeSystem: DMEDPrescriptionStatusCS
Id: dmed-prescription-status-cs
Title: "DMED Prescription Status Codes"
Description: "Source business statuses observed in GET /api/prescriptions/v1/prescriptions on 2026-09-17. Codes reproduce the DMED API query and payload values exactly."
* ^url = $dmed-prescription-status-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "Uzinfocom"
* #approve "Approved"
  * ^designation.language = #ru
  * ^designation.value = "Подтвержден"
* #awaiting_confirmation "Awaiting confirmation"
  * ^designation.language = #ru
  * ^designation.value = "Ожидает подтверждения"
* #revision "Revision requested"
  * ^designation.language = #ru
  * ^designation.value = "На доработку"
* #created "Not issued"
  * ^designation.language = #ru
  * ^designation.value = "Не выдан"
* #partially_issued "Partially issued"
  * ^designation.language = #ru
  * ^designation.value = "Частично выдан"
* #issued "Issued"
  * ^designation.language = #ru
  * ^designation.value = "Выдан"
* #expired "Expired"
  * ^designation.language = #ru
  * ^designation.value = "Срок истек"
* #canceled "Cancelled"
  * ^designation.language = #ru
  * ^designation.value = "Отменен"
* #not_signed "Not signed"
  * ^designation.language = #ru
  * ^designation.value = "Не подписан"

ValueSet: DMEDPrescriptionStatusVS
Id: dmed-prescription-status-vs
Title: "DMED Prescription Statuses"
Description: "Source statuses used by the DMED Prescription workflow."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/dmed-prescription-status-vs"
* ^status = #active
* ^experimental = false
* include codes from system DMEDPrescriptionStatusCS

CodeSystem: DMEDPrescriptionRouteCS
Id: dmed-prescription-route-cs
Title: "DMED Prescription Route Identifiers"
Description: "Numeric route identifiers returned in drug_appointment.drug_administration_route by the DMED Prescription API. This fragment contains only identifiers directly observed and terminology-validated for Prescription."
* ^url = $dmed-prescription-route-cs
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "Uzinfocom"
* #4 "Ocular"
  * ^designation.language = #ru
  * ^designation.value = "Окулярный"

ValueSet: DMEDPrescriptionRouteVS
Id: dmed-prescription-route-vs
Title: "Verified DMED Prescription Routes"
Description: "DMED Prescription route identifiers for which an approved FHIR terminology crosswalk is published."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/dmed-prescription-route-vs"
* ^status = #active
* ^experimental = false
* include codes from system DMEDPrescriptionRouteCS
