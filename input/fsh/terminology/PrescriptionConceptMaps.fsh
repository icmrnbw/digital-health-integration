Instance: dmed-prescription-type-to-prescription-type
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Prescription Type to Prescription Type"
Description: "Maps the DMED API type values to the A and R prescription types displayed to users."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-prescription-type-to-prescription-type"
* name = "DMEDPrescriptionTypeToPrescriptionType"
* status = #active
* experimental = false
* publisher = "Uzinfocom"
* sourceScopeCanonical = Canonical(DMEDPrescriptionTypeVS)
* targetScopeCanonical = Canonical(PrescriptionTypeVS)
* group.source = Canonical(DMEDPrescriptionTypeCS)
* group.target = Canonical(PrescriptionTypeCS)
* group.element[+].code = #simple
* group.element[=].target[+].code = #A
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #reimbursement
* group.element[=].target[+].code = #R
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-prescription-status-to-medication-request-status
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Prescription Status to MedicationRequest Status"
Description: "Maps DMED workflow statuses to the closest FHIR MedicationRequest clinical status. Approval state remains authoritative in PrescriptionApprovalTask.businessStatus."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-prescription-status-to-medication-request-status"
* name = "DMEDPrescriptionStatusToMedicationRequestStatus"
* status = #active
* experimental = false
* publisher = "Uzinfocom"
* sourceScopeCanonical = Canonical(DMEDPrescriptionStatusVS)
* group.source = Canonical(DMEDPrescriptionStatusCS)
* group.target = $medicationrequest-status
* group.element[+].code = #not_signed
* group.element[=].target[+].code = #draft
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #awaiting_confirmation
* group.element[=].target[+].code = #active
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #approve
* group.element[=].target[+].code = #active
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #revision
* group.element[=].target[+].code = #on-hold
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #created
* group.element[=].target[+].code = #active
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #partially_issued
* group.element[=].target[+].code = #active
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #issued
* group.element[=].target[+].code = #completed
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #expired
* group.element[=].target[+].code = #ended
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #canceled
* group.element[=].target[+].code = #cancelled
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-prescription-route-to-fhir-route
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Prescription Route to FHIR Route"
Description: "Maps numeric route identifiers observed in the DMED Prescription API to SNOMED CT routes accepted by the UZ Core RouteCodeVS. The map is intentionally partial until an authoritative DMED export is available."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-prescription-route-to-fhir-route"
* name = "DMEDPrescriptionRouteToFHIRRoute"
* status = #active
* experimental = false
* publisher = "Uzinfocom"
* sourceScopeCanonical = Canonical(DMEDPrescriptionRouteVS)
* group.source = Canonical(DMEDPrescriptionRouteCS)
* group.target = $sct
* targetScopeCanonical = $route-code-vs
* group.element[+].code = #4
* group.element[=].target[+].code = #372472002
* group.element[=].target[=].display = "Ocular route"
* group.element[=].target[=].relationship = #equivalent
