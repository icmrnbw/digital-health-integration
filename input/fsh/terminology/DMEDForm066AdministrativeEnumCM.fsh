Instance: dmed-form-066-payment-type-to-coverage-type
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Payment Type to Coverage Type"
Description: "Maps DMED payment_type values to national coverage type codes. The broad PF-17 insurance value maps to the three more specific PF-17 fund categories."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-payment-type-to-coverage-type"
* name = "DMEDForm066PaymentTypeToCoverageType"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066PaymentTypeCS)
* group.target = $coverage-type
* group.element[+].code = #insurance_311_resolution
* group.element[=].display = "Фонд страхования по ПП-311"
* group.element[=].target[+].code = #dtsj-treated-case
* group.element[=].target[=].display = "State Health Insurance treated case (Resolution No. PQ-311)"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #insurance_5199_resolution
* group.element[=].display = "Фонд стархования по ПП-5199"
* group.element[=].target[+].code = #dtsj-privileged-category
* group.element[=].target[=].display = "State Health Insurance treatment of patients belonging to privileged categories (Resolution No. PQ-5199)"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #fond_VAQF
* group.element[=].display = "VAQF - Благотворительный общественный фонд"
* group.element[=].target[+].code = #saxovat-komak-fund
* group.element[=].target[=].display = "Sakhovat and Support Fund through State Health Insurance"
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #insurance_17_decree
* group.element[=].display = "Фонд страхования по УП-17 от 30.01.2025"
* group.element[=].target[+].code = #saxovat-komak-fund
* group.element[=].target[=].display = "Sakhovat and Support Fund through State Health Insurance"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #womens-notebook-fund
* group.element[=].target[=].display = "Women's Notebook Fund through State Health Insurance"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #youth-notebook-fund
* group.element[=].target[=].display = "Youth Notebook Fund through State Health Insurance"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #local_budget
* group.element[=].display = "Местный бюджет"
* group.element[=].target[+].code = #local-budget
* group.element[=].target[=].display = "Local budget"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #sponsorship
* group.element[=].display = "Спонсорство"
* group.element[=].target[+].code = #sponsorship
* group.element[=].target[=].display = "Sponsorship"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #state_nonstate_grant
* group.element[=].display = "Государственные и негосударственные гранты"
* group.element[=].target[+].code = #state-and-nonstate-grants
* group.element[=].target[=].display = "State and non-state grants"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #other
* group.element[=].display = "Другие"
* group.element[=].target[+].code = #other
* group.element[=].target[=].display = "Other"
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-social-status-to-national
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Social Status to National Social Status"
Description: "Maps DMED social_status values to the national social status code system."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-social-status-to-national"
* name = "DMEDForm066SocialStatusToNational"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066SocialStatusCS)
* group.target = $social-status
* group.element[+].code = #student
* group.element[=].display = "Студент"
* group.element[=].target[+].code = #regis0010.00001
* group.element[=].target[=].display = "Student"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #working
* group.element[=].display = "Работает"
* group.element[=].target[+].code = #regis0010.00003
* group.element[=].target[=].display = "Employed"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #not_working
* group.element[=].display = "Не работает"
* group.element[=].target[+].code = #regis0010.00004
* group.element[=].target[=].display = "Unemployed"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #military
* group.element[=].display = "Военная служба"
* group.element[=].target[+].code = #regis0010.00009
* group.element[=].target[=].display = "Military serviceman"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #school_student
* group.element[=].display = "Учится в школе"
* group.element[=].target[+].code = #regis0010.00010
* group.element[=].target[=].display = "School student"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #preferential_category
* group.element[=].display = "Есть льготная категория"
* group.element[=].target[+].code = #regis0010.00011
* group.element[=].target[=].display = "Eligible for benefits"
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-benefit-category-to-national
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Benefit Category to National Benefits"
Description: "Maps DMED beneficiary category values to the national benefits code system. The hematological-disease category has no target in the current national list."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-benefit-category-to-national"
* name = "DMEDForm066BenefitCategoryToNational"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066BenefitCategoryCS)
* group.target = $benefit-cs
* group.element[+].code = #childhood_disability
* group.element[=].target[+].code = #regis0004.00001
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #orphans
* group.element[=].target[+].code = #regis0004.00002
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #disabled_groups_i_ii
* group.element[=].target[+].code = #regis0004.00003
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #war_veterans_1941_1945
* group.element[=].target[+].code = #regis0004.00004
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #unemployed_pensioners
* group.element[=].target[+].code = #regis0004.00005
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #labor_front_participants
* group.element[=].target[+].code = #regis0004.00006
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #chernobyl_liquidators
* group.element[=].target[+].code = #regis0004.00007
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #international_soldiers
* group.element[=].target[+].code = #regis0004.00008
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #low_income_families
* group.element[=].target[+].code = #regis0004.00009
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #children_with_pathology
* group.element[=].target[+].code = #regis0004.00010
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #conscripts
* group.element[=].target[+].code = #regis0004.00011
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #pregnant_women_with_pathology
* group.element[=].target[+].code = #regis0004.00012
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #endocrine_disease_patients
* group.element[=].target[+].code = #regis0004.00013
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #std_patients
* group.element[=].target[+].code = #regis0004.00014
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #tuberculosis_patients
* group.element[=].target[+].code = #regis0004.00015
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #cancer_patients
* group.element[=].target[+].code = #regis0004.00016
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #hemodialysis_patients
* group.element[=].target[+].code = #regis0004.00017
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #deceased_military_families
* group.element[=].target[+].code = #regis0004.00018
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #medical_workers
* group.element[=].target[+].code = #regis0004.00019
* group.element[=].target[=].relationship = #source-is-narrower-than-target
* group.element[+].code = #hematological_disease_patients
* group.element[=].noMap = true

Instance: dmed-form-066-diagnosis-type-to-role
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Diagnosis Type to Diagnosis Role"
Description: "Maps DMED disease-codes type values to Form 066 diagnosis roles. The generic clinical type has no unambiguous target role."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-diagnosis-type-to-role"
* name = "DMEDForm066DiagnosisTypeToRole"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066DiagnosisTypeCS)
* group.target = Canonical(DiagnosisRoleCS)
* group.element[+].code = #main
* group.element[=].target[+].code = #main
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #competing
* group.element[=].target[+].code = #competing
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #additional
* group.element[=].target[+].code = #concomitant
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #background
* group.element[=].target[+].code = #background
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #critical
* group.element[=].target[+].code = #complication
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #clinical
* group.element[=].noMap = true

Instance: dmed-form-066-arrival-type-to-normalized
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Arrival Type to Normalized Arrival Type"
Description: "Maps DMED arrival_type values, including its misspelled source code, to stable Form 066 arrival type codes."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-arrival-type-to-normalized"
* name = "DMEDForm066ArrivalTypeToNormalized"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066ArrivalTypeCS)
* group.target = Canonical(Form066ArrivalTypeCS)
* group.element[+].code = #accompaned-by-police
* group.element[=].target[+].code = #accompanied-by-police
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #by-ambulance
* group.element[=].target[+].code = #ambulance
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #other
* group.element[=].target[+].code = #other
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #self-referred
* group.element[=].target[+].code = #self-referred
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-transportation-kind-to-normalized
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Transportation Kind to Normalized Transportation Kind"
Description: "Maps DMED transportation_kind values to stable Form 066 transportation mode codes."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-transportation-kind-to-normalized"
* name = "DMEDForm066TransportationKindToNormalized"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066TransportationKindCS)
* group.target = Canonical(Form066TransportationKindCS)
* group.element[+].code = #carried-in-arms
* group.element[=].target[+].code = #carried
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #crutches
* group.element[=].target[+].code = #crutches
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #stretcher
* group.element[=].target[+].code = #stretcher
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #walk
* group.element[=].target[+].code = #ambulatory
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #wheelchair
* group.element[=].target[+].code = #wheelchair
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-hospitalization-reason-to-normalized
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Hospitalization Reason to Normalized Reason"
Description: "Maps DMED hospitalization_reason values to stable Form 066 hospitalization reason codes."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-hospitalization-reason-to-normalized"
* name = "DMEDForm066HospitalizationReasonToNormalized"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066HospitalizationReasonCS)
* group.target = Canonical(Form066HospitalizationReasonCS)
* group.element[+].code = #car_accident
* group.element[=].target[+].code = #road-traffic-accident
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #disease
* group.element[=].target[+].code = #disease
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #injury
* group.element[=].target[+].code = #injury
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #planned
* group.element[=].target[+].code = #planned-admission
* group.element[=].target[=].relationship = #equivalent
