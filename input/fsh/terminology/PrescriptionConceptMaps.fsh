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
Description: "Maps DMED workflow statuses to the closest FHIR MedicationRequest clinical status. Approval state remains authoritative in PrescriptionApprovalTask.businessStatus. DMED sends a prescription to DHP only once it is signed, so `not_signed` is not mapped."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-prescription-status-to-medication-request-status"
* name = "DMEDPrescriptionStatusToMedicationRequestStatus"
* status = #active
* experimental = false
* publisher = "Uzinfocom"
* sourceScopeCanonical = Canonical(DMEDPrescriptionStatusVS)
* group.source = Canonical(DMEDPrescriptionStatusCS)
* group.target = $medicationrequest-status
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
Description: "Maps DMED `drug_administration_route_id` to SNOMED CT routes of administration in UZ Core RouteCodeVS. Only routes with an unambiguous SNOMED CT equivalent are mapped. Identifiers that name a method rather than a route (Инъекционно, Парентеральный, Инстилляция) or that combine two routes are left out; a prescription with such a route is rejected with `terminology-crosswalk-not-found`."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-prescription-route-to-fhir-route"
* name = "DMEDPrescriptionRouteToFHIRRoute"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* sourceScopeCanonical = Canonical(DMEDPrescriptionRouteVS)
* group.source = Canonical(DMEDPrescriptionRouteCS)
* group.target = $sct
* targetScopeCanonical = $route-code-vs
* group.element[+].code = #1
* group.element[=].display = "Пероральный"
* group.element[=].target[+].code = #26643006
* group.element[=].target[=].display = "Oral route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3
* group.element[=].display = "Внутримышечный"
* group.element[=].target[+].code = #78421000
* group.element[=].target[=].display = "Intramuscular route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #4
* group.element[=].display = "Окулярный"
* group.element[=].target[+].code = #372472002
* group.element[=].target[=].display = "Ocular route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #38
* group.element[=].display = "Внутривенный"
* group.element[=].target[+].code = #47625008
* group.element[=].target[=].display = "Intravenous route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #56
* group.element[=].display = "Вагинальный"
* group.element[=].target[+].code = #16857009
* group.element[=].target[=].display = "Vaginal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #87
* group.element[=].display = "Наружный"
* group.element[=].target[+].code = #6064005
* group.element[=].target[=].display = "Topical route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #128
* group.element[=].display = "Ректальный"
* group.element[=].target[+].code = #37161004
* group.element[=].target[=].display = "Rectal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #162
* group.element[=].display = "Местный"
* group.element[=].target[+].code = #6064005
* group.element[=].target[=].display = "Topical route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #610
* group.element[=].display = "Назальный"
* group.element[=].target[+].code = #46713006
* group.element[=].target[=].display = "Nasal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #2742
* group.element[=].display = "Ушной"
* group.element[=].target[+].code = #10547007
* group.element[=].target[=].display = "Otic route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3866
* group.element[=].display = "Подкожный"
* group.element[=].target[+].code = #34206005
* group.element[=].target[=].display = "Subcutaneous route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3867
* group.element[=].display = "Внутриартериальный"
* group.element[=].target[+].code = #58100008
* group.element[=].target[=].display = "Intra-arterial route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3868
* group.element[=].display = "Внутрикожный"
* group.element[=].target[+].code = #372464004
* group.element[=].target[=].display = "Intradermal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3872
* group.element[=].display = "Интраназальный"
* group.element[=].target[+].code = #46713006
* group.element[=].target[=].display = "Nasal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3873
* group.element[=].display = "Внутрисуставный"
* group.element[=].target[+].code = #12130007
* group.element[=].target[=].display = "Intra-articular route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3878
* group.element[=].display = "Интравагинально"
* group.element[=].target[+].code = #16857009
* group.element[=].target[=].display = "Vaginal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3883
* group.element[=].display = "Трансдермальный"
* group.element[=].target[+].code = #45890007
* group.element[=].target[=].display = "Transdermal route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3884
* group.element[=].display = "Сублингвальный"
* group.element[=].target[+].code = #37839007
* group.element[=].target[=].display = "Sublingual route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3889
* group.element[=].display = "Подъязычный"
* group.element[=].target[+].code = #37839007
* group.element[=].target[=].display = "Sublingual route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3894
* group.element[=].display = "Глазные"
* group.element[=].target[+].code = #372472002
* group.element[=].target[=].display = "Ocular route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3899
* group.element[=].display = "Под язычное"
* group.element[=].target[+].code = #37839007
* group.element[=].target[=].display = "Sublingual route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3902
* group.element[=].display = "Внутрь"
* group.element[=].target[+].code = #26643006
* group.element[=].target[=].display = "Oral route"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #3903
* group.element[=].display = "Ректальное"
* group.element[=].target[+].code = #37161004
* group.element[=].target[=].display = "Rectal route"
* group.element[=].target[=].relationship = #equivalent
