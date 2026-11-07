// DMED source tokens used by Form 027 (hospitalization referral `purpose[]` and
// diagnosis `disease_codes` keys / `type`). Purpose tokens are from the referral
// JSON (GET .../hospitalization-referral/{id}, 2026-09-18); diagnosis types match
// the live "Выберите тип" dropdown that Form 066 maps (checked 2026-09-16).

CodeSystem: DMEDForm027HospitalizationPurposeCS
Id: dmed-form-027-hospitalization-purpose-cs
Title: "DMED Form 027 purpose"
Description: "Source tokens for purpose[] (purpose of hospitalization, multi-select) on the DMED hospitalization referral that Form 027 refers to."
* ^url = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/dmed-form-027-hospitalization-purpose-cs"
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^language = #ru
* #"diagnostics" "Диагностика"
* #"consultation" "Консультация"
* #"treatment" "Лечение"
* #"examination" "Осмотр"
* #"dispensary-control" "Д-контроль"
* #"delivery" "Родоразрешение"
* #"other" "Другое"

CodeSystem: DMEDForm027DiagnosisTypeCS
Id: dmed-form-027-diagnosis-type-cs
Title: "DMED Form 027 diagnosis type"
Description: "Source tokens for the diagnosis type in DMED: the `type` of a disease code and the keys of `disease_codes` / `clinical_diagnoses_ids` on the hospitalization referral (main diagnosis in `main_disease_code`)."
* ^url = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/dmed-form-027-diagnosis-type-cs"
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^language = #ru
* #"main" "Основной"
* #"additional" "Сопутствующий"
* #"background" "Фоновый"
* #"critical" "Осложнение"
* #"competing" "Конкурирующий"
