// Stable integration codes used where no suitable national or international target code system exists.

CodeSystem: Form066TreatmentOutcomeCS
Id: form-066-treatment-outcome-cs
Title: "Form 066 Treatment Outcome"
Description: "Normalized treatment outcome codes for Form 066."
* insert OriginalCodeSystemDraft(form-066-treatment-outcome-cs)
* ^language = #en
* #improved "Improved"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Стало лучше"
* #death-confirmed "Death confirmed"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Констатация смерти"
* #deteriorated "Deteriorated"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Ухудшение"
* #no-change "No change"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Без изменений"
* #recovered "Recovered"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Выздоровел"

CodeSystem: Form066ArrivalTypeCS
Id: form-066-arrival-type-cs
Title: "Form 066 Arrival Type"
Description: "Normalized patient arrival mode codes for Form 066."
* insert OriginalCodeSystemDraft(form-066-arrival-type-cs)
* ^language = #en
* #accompanied-by-police "Accompanied by police"
  * ^designation[0].language = #ru
  * ^designation[=].value = "В сопровождении сотрудника ГУВД"
* #ambulance "Ambulance"
  * ^designation[0].language = #ru
  * ^designation[=].value = "На машине скорой помощи"
* #other "Other"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Другое"
* #self-referred "Self-referred"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Обратился самостоятельно"

CodeSystem: Form066TransportationKindCS
Id: form-066-transportation-kind-cs
Title: "Form 066 Transportation Kind"
Description: "Normalized patient transportation mode codes for Form 066."
* insert OriginalCodeSystemDraft(form-066-transportation-kind-cs)
* ^language = #en
* #carried "Carried in arms"
  * ^designation[0].language = #ru
  * ^designation[=].value = "На руках"
* #crutches "Crutches"
  * ^designation[0].language = #ru
  * ^designation[=].value = "На костылях"
* #stretcher "Stretcher"
  * ^designation[0].language = #ru
  * ^designation[=].value = "На носилках"
* #ambulatory "Able to walk"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Может идти"
* #wheelchair "Wheelchair"
  * ^designation[0].language = #ru
  * ^designation[=].value = "На кресле"

CodeSystem: Form066HospitalizationReasonCS
Id: form-066-hospitalization-reason-cs
Title: "Form 066 Hospitalization Reason"
Description: "Normalized hospitalization reason codes for Form 066."
* insert OriginalCodeSystemDraft(form-066-hospitalization-reason-cs)
* ^language = #en
* #road-traffic-accident "Road traffic accident"
  * ^designation[0].language = #ru
  * ^designation[=].value = "ДТП"
* #disease "Disease"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Заболевание"
* #injury "Injury"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Травма"
* #planned-admission "Planned admission"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Плановая госпитализация"
