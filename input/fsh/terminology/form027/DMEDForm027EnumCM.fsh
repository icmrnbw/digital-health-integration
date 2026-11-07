// ConceptMaps from DMED Form 027 tokens (dmed-form-027-*-cs) to the codes the
// Form 027 document sends.

Instance: dmed-form-027-hospitalization-purpose-cm
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 027 purpose mapping"
Description: "Maps DMED hospitalization referral `purpose[]` to `hospitalization-purpose-cs`, sent in ServiceRequest.reason.concept of the Form 027 hospitalization request. Each DMED value becomes its own reason; `other` also carries the DMED `other_purpose` text in reason.concept.text."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-027-hospitalization-purpose-cm"
* name = "DMEDForm027HospitalizationPurposeCM"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group[+].source = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/dmed-form-027-hospitalization-purpose-cs"
* group[=].target = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/hospitalization-purpose-cs"
* group[=].element[+].code = #"diagnostics"
* group[=].element[=].display = "Диагностика"
* group[=].element[=].target[+].code = #"diagnostics"
* group[=].element[=].target[=].display = "Diagnostika"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"consultation"
* group[=].element[=].display = "Консультация"
* group[=].element[=].target[+].code = #"consultation"
* group[=].element[=].target[=].display = "Konsultativ"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"treatment"
* group[=].element[=].display = "Лечение"
* group[=].element[=].target[+].code = #"treatment"
* group[=].element[=].target[=].display = "Davolash"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"examination"
* group[=].element[=].display = "Осмотр"
* group[=].element[=].target[+].code = #"examination"
* group[=].element[=].target[=].display = "Ko'rik"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"dispensary-control"
* group[=].element[=].display = "Д-контроль"
* group[=].element[=].target[+].code = #"dispensary-control"
* group[=].element[=].target[=].display = "D-nazorat"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"delivery"
* group[=].element[=].display = "Родоразрешение"
* group[=].element[=].target[+].code = #"delivery"
* group[=].element[=].target[=].display = "Tug'ruq"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"other"
* group[=].element[=].display = "Другое"
* group[=].element[=].target[+].code = #"other"
* group[=].element[=].target[=].display = "Boshqa"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[=].target[=].comment = "Send the DMED other_purpose text in ServiceRequest.reason.concept.text of the same reason."

Instance: dmed-form-027-diagnosis-type-cm
InstanceOf: ConceptMap
Usage: #definition
Title: "DMED Form 027 diagnosis type mapping"
Description: "Maps the DMED diagnosis type to `diagnosis-role-integration`, sent in Condition.category and used as the code of the matching sub-section of the Form 027 referral and diagnosis section."
* url = "https://terminology.dhp.uz/fhir/integrations/ConceptMap/dmed-form-027-diagnosis-type-cm"
* name = "DMEDForm027DiagnosisTypeCM"
* status = #draft
* experimental = false
* publisher = "Uzinfocom"
* group[+].source = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/dmed-form-027-diagnosis-type-cs"
* group[=].target = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/diagnosis-role-integration"
* group[=].element[+].code = #"main"
* group[=].element[=].display = "Основной"
* group[=].element[=].target[+].code = #"main"
* group[=].element[=].target[=].display = "Asosiy tashxis"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"additional"
* group[=].element[=].display = "Сопутствующий"
* group[=].element[=].target[+].code = #"concomitant"
* group[=].element[=].target[=].display = "Yondosh tashxis"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"background"
* group[=].element[=].display = "Фоновый"
* group[=].element[=].target[+].code = #"background"
* group[=].element[=].target[=].display = "Fon tashxis"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"critical"
* group[=].element[=].display = "Осложнение"
* group[=].element[=].target[+].code = #"complication"
* group[=].element[=].target[=].display = "Asorat"
* group[=].element[=].target[=].relationship = #equivalent
* group[=].element[+].code = #"competing"
* group[=].element[=].display = "Конкурирующий"
* group[=].element[=].target[+].code = #"competing"
* group[=].element[=].target[=].display = "Raqobat tashxis"
* group[=].element[=].target[=].relationship = #equivalent
