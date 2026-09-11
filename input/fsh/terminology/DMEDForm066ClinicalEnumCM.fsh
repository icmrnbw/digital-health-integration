Instance: dmed-form-066-medical-care-form-to-priority
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Medical Care Form to Encounter Priority"
Description: "Maps DMED medical_care_form values to the standard or national Encounter priority codes used by Form 066."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-medical-care-form-to-priority"
* name = "DMEDForm066MedicalCareFormToPriority"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group[+].source = Canonical(DMEDForm066MedicalCareFormCS)
* group[=].target = $v3ActPriority
* group[=].element[+].code = #emergency
* group[=].element[=].display = "Экстренная"
* group[=].element[=].target[+].code = #EM
* group[=].element[=].target[=].display = "Emergency"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #planned
* group[=].element[=].display = "Плановая"
* group[=].element[=].target[+].code = #R
* group[=].element[=].target[=].display = "Routine"
* group[=].element[=].target[=].relationship = #related-to
* group[=].element[+].code = #urgent
* group[=].element[=].display = "Неотложная"
* group[=].element[=].target[+].code = #UR
* group[=].element[=].target[=].display = "Urgent"
* group[=].element[=].target[=].relationship = #equivalent
* group[+].source = Canonical(DMEDForm066MedicalCareFormCS)
* group[=].target = $encounter-local-priority-cs
* group[=].element[+].code = #transferred
* group[=].element[=].display = "Переведен из другого учреждения"
* group[=].element[=].target[+].code = #transferred
* group[=].element[=].target[=].display = "Transferred from another facility"
* group[=].element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-urgency-time-to-disease-injury-delay
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Urgency Time to Disease/Injury Delay"
Description: "Maps DMED urgency_time values to the Form 066 disease/injury delay code system."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-urgency-time-to-disease-injury-delay"
* name = "DMEDForm066UrgencyTimeToDiseaseInjuryDelay"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066UrgencyTimeCS)
* group.target = Canonical(DiseaseInjuryDelayCS)
* group.element[+].code = #first_6_hours
* group.element[=].display = "В течение первых 6 часов"
* group.element[=].target[+].code = #delay0001_00001
* group.element[=].target[=].display = "Within first 6 hours"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #before_24_hours
* group.element[=].display = "В течение 7-24 часов"
* group.element[=].target[+].code = #delay0001_00002
* group.element[=].target[=].display = "Within 7-24 hours"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #after_24_hours
* group.element[=].display = "После 24 часов"
* group.element[=].target[+].code = #delay0001_00003
* group.element[=].target[=].display = "After 24 hours"
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-bed-type-to-organizational-specialization
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Bed Type to Organizational Specialization"
Description: "Maps DMED bed_type values to the national organizational specialization code system. Composite source categories map to each applicable narrower target. Geriatrics has no target in the current national code system."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-bed-type-to-organizational-specialization"
* name = "DMEDForm066BedTypeToOrganizationalSpecialization"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066BedTypeCS)
* group.target = $location-form
* group.element[+].code = #therapeutic
* group.element[=].display = "Терапевтический"
* group.element[=].target[+].code = #101.0
* group.element[=].target[=].display = "Therapy"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #pediatric
* group.element[=].display = "Педиатрический"
* group.element[=].target[+].code = #170.0
* group.element[=].target[=].display = "Pediatrics (somatic)"
* group.element[=].target[=].relationship = #related-to
* group.element[+].code = #surgical
* group.element[=].display = "Хирургический"
* group.element[=].target[+].code = #122.0
* group.element[=].target[=].display = "Adult Surgery"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #123.0
* group.element[=].target[=].display = "Pediatric Surgery"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #obstetrics_gynecology
* group.element[=].display = "Акушеро-гинекологический"
* group.element[=].target[+].code = #148.0
* group.element[=].target[=].display = "For pregnant women, women in labor and postpartum women"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #150.0
* group.element[=].target[=].display = "Adult gynecology"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #resuscitation
* group.element[=].display = "Реанимационный (интенсивная терапия)"
* group.element[=].target[+].code = #174.0
* group.element[=].target[=].display = "Intensive care for adults"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #175.0
* group.element[=].target[=].display = "Children's intensive care"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #infectious_diseases
* group.element[=].display = "Инфекционные заболевания"
* group.element[=].target[+].code = #112.0
* group.element[=].target[=].display = "Adult Infectious Diseases"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #113.0
* group.element[=].target[=].display = "Pediatric Infectious Diseases"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #narcology_psychiatry
* group.element[=].display = "Наркология-психиатрия"
* group.element[=].target[+].code = #157.0
* group.element[=].target[=].display = "Adult psychiatry (psychoneurology)"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #158.0
* group.element[=].target[=].display = "Child psychiatry"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #161.0
* group.element[=].target[=].display = "Narcological"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #other
* group.element[=].display = "Другие"
* group.element[=].target[+].code = #172.0
* group.element[=].target[=].display = "Other for adults"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[=].target[+].code = #173.0
* group.element[=].target[=].display = "Other for children"
* group.element[=].target[=].relationship = #source-is-broader-than-target
* group.element[+].code = #geriatrics
* group.element[=].display = "Гериатрия"
* group.element[=].noMap = true

Instance: dmed-form-066-treatment-result-to-discharge-disposition
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Treatment Result to Discharge Disposition"
Description: "Maps DMED result_treatment values that represent discharge disposition. Detailed death contexts map to the broader Expired code; health-state outcomes have no discharge-disposition mapping."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-treatment-result-to-discharge-disposition"
* name = "DMEDForm066TreatmentResultToDischargeDisposition"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group[+].source = Canonical(DMEDForm066TreatmentResultCS)
* group[=].target = $discharge-disposition
* group[=].element[+].code = #deceased
* group[=].element[=].display = "Скончался"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #deceased_after_28_weeks
* group[=].element[=].display = "Скончалась после 28й недели беременности"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #source-is-narrower-than-target
* group[=].element[+].code = #deceased_after_childbirth
* group[=].element[=].display = "Скончалась после родов"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #source-is-narrower-than-target
* group[=].element[+].code = #deceased_before_28_weeks
* group[=].element[=].display = "Скончалась до 28й недели беременности"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #source-is-narrower-than-target
* group[=].element[+].code = #deceased_before_childbirth
* group[=].element[=].display = "Скончалась до родов"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #source-is-narrower-than-target
* group[=].element[+].code = #deceased_in_er
* group[=].element[=].display = "Скончался(ась) в приемном покое"
* group[=].element[=].target[+].code = #exp
* group[=].element[=].target[=].display = "Expired"
* group[=].element[=].target[=].relationship = #source-is-narrower-than-target
* group[=].element[+].code = #transferred_to_another_facility
* group[=].element[=].display = "Переведен в другое медицинское учреждение"
* group[=].element[=].target[+].code = #other-hcf
* group[=].element[=].target[=].display = "Other healthcare facility"
* group[=].element[=].target[=].relationship = #equivalent
* group[+].source = Canonical(DMEDForm066TreatmentResultCS)
* group[=].target = $discharge-disposition-home-cs
* group[=].element[+].code = #discharged
* group[=].element[=].display = "Выписан"
* group[=].element[=].target[+].code = #mserv-0004-00004
* group[=].element[=].target[=].display = "Discharged"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #discharged_at_his_own_request
* group[=].element[=].display = "Выписан по собственному желанию"
* group[=].element[=].target[+].code = #mserv-0004-00003
* group[=].element[=].target[=].display = "Self left from hospital"
* group[=].element[=].target[=].relationship = #related-to
* group[+].source = Canonical(DMEDForm066TreatmentResultCS)
* group[=].element[+].code = #healthy
* group[=].element[=].display = "Выписан из больницы: здоров"
* group[=].element[=].noMap = true
* group[=].element[+].code = #no_change
* group[=].element[=].display = "Выписан из больницы: без изменений"
* group[=].element[=].noMap = true
* group[=].element[+].code = #slight_improvement
* group[=].element[=].display = "Выписан из больницы: незначительное улучшение"
* group[=].element[=].noMap = true

Instance: dmed-form-066-treatment-outcome-to-normalized
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Treatment Outcome to Normalized Outcome"
Description: "Maps DMED outcome_treatment values to stable Form 066 treatment outcome codes."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-treatment-outcome-to-normalized"
* name = "DMEDForm066TreatmentOutcomeToNormalized"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066TreatmentOutcomeCS)
* group.target = Canonical(Form066TreatmentOutcomeCS)
* group.element[+].code = #better
* group.element[=].display = "Стало лучше"
* group.element[=].target[+].code = #improved
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #death_certificate
* group.element[=].display = "Констатация смерти"
* group.element[=].target[+].code = #death-confirmed
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #deterioration
* group.element[=].display = "Ухудшение"
* group.element[=].target[+].code = #deteriorated
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #no_change
* group.element[=].display = "Без изменений"
* group.element[=].target[+].code = #no-change
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #recovered
* group.element[=].display = "Выздоровел"
* group.element[=].target[+].code = #recovered
* group.element[=].target[=].relationship = #equivalent

Instance: dmed-form-066-tuberculosis-resistance-to-sensitivity
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 066 Tuberculosis Resistance to Drug Susceptibility"
Description: "Maps DMED tuberculosis_treatment_resistance values to the Form 066 tuberculosis drug susceptibility codes."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-066-tuberculosis-resistance-to-sensitivity"
* name = "DMEDForm066TuberculosisResistanceToSensitivity"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group.source = Canonical(DMEDForm066TuberculosisResistanceCS)
* group.target = Canonical(TBDrugSensitivityCS)
* group.element[+].code = #not_resistant
* group.element[=].display = "Чувствителен"
* group.element[=].target[+].code = #Tub-004-001
* group.element[=].target[=].display = "Drug-sensitive"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #monoresistant
* group.element[=].display = "Монорезистентность"
* group.element[=].target[+].code = #Tub-004-002
* group.element[=].target[=].display = "Mono-resistant"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #polyresistant
* group.element[=].display = "Полирезистентность"
* group.element[=].target[+].code = #Tub-004-003
* group.element[=].target[=].display = "Poly-resistant"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #multiresistant
* group.element[=].display = "Мультирезистентность"
* group.element[=].target[+].code = #Tub-004-004
* group.element[=].target[=].display = "Multidrug-resistant (MDR-TB)"
* group.element[=].target[=].relationship = #equivalent
* group.element[+].code = #extremely_resistant
* group.element[=].display = "Чрезвычайная резистентность"
* group.element[=].target[+].code = #Tub-004-005
* group.element[=].target[=].display = "Extensively drug-resistant (XDR-TB)"
* group.element[=].target[=].relationship = #equivalent
