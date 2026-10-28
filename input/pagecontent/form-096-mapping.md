<style>
.col-12 table.mapping-fields { table-layout: fixed; width: 100%; }
.col-12 .mapping-fields th, .col-12 .mapping-fields td { overflow-wrap: anywhere; word-break: break-word; vertical-align: top; }
.col-12 .mapping-fields th:nth-child(1), .col-12 .mapping-fields td:nth-child(1) { width: 17%; }
.col-12 .mapping-fields th:nth-child(2), .col-12 .mapping-fields td:nth-child(2) { width: 20%; }
.col-12 .mapping-fields th:nth-child(3), .col-12 .mapping-fields td:nth-child(3) { width: 28%; }
.col-12 .mapping-fields th:nth-child(4), .col-12 .mapping-fields td:nth-child(4) { width: 23%; }
.col-12 .mapping-fields th:nth-child(5), .col-12 .mapping-fields td:nth-child(5) { width: 12%; }
</style>

### Form 096 — Maternity Medical Record: Field Mapping

### Overview

This page maps supported Form 096 fields and supplied DMED data to FHIR R5. Use the [Form 096 Composition](StructureDefinition-form-096-maternity-medical-record-composition.html) with UZ Core resources. The [complete synthetic document](Bundle-example-form-096-maternity-medical-record.html) illustrates a broad record; it does not prove that every example field is available in DMED.

### Data and identity rules

- Clinical facts and sections are optional by availability. Omit unavailable resources/components; preserve genuine 0 and false. Required FHIR/Core metadata and identifiers remain required. UI-required fields do not create additional integration minimums.
- Use the Form 066 identity, resource-phase and revision workflow. The mother has one shared master Encounter for 066/096; each document retains its historical snapshot. Document POST alone does not upsert master resources. Distinguish stable business identity from Bundle revision identity. UUID examples use urn:ietf:rfc:3986; the form-number value 096 is not a unique card identifier.
- Most measurements are separate maternal Observations. Explicit component paths describe the worked example's supported clinical components; do not emit the same fact twice. Individual birth facts have the child as subject. Shared labor/placenta facts retain the mother, maternal Encounter and stable fact IDs in 096/097. The child has its own hospitalization.
- Birth outcome: LOINC 63893-2 → SCT 281050002 Livebirth or 237364002 Stillbirth. A known antepartum/intrapartum period is a separate child Condition, 237361005/237362003. Death after livebirth does not change the birth outcome. Death uses Patient.deceasedDateTime when known, or deceasedBoolean=true when only the fact is known; update the master Patient as well as the snapshot.
- Incoming DMED Apgar is the one-minute total, 9272-6. Do not invent five-minute or component scores. UI requires a score even for stillbirth: confirm whether a received value is an actual assessment; never turn absence into 0. Durations use UCUM min: 01:30 means 90 minutes. Missing III is not zero, and an I–II subtotal is not a full I–III duration. The end of three-stage labor is not the birth of the last child. Preserve source date precision.
- Pelvimetry uses six separate maternal Observations. C. diagonalis uses SCT 249011002. Do not silently substitute an obstetric-conjugate code for C. vera. Maternal discharge follows the Core Encounter binding; receiving organization belongs in admission.destination. Placental-delivery method is not Procedure.outcome.
- Use the selected physician/midwife as the Form 096 authors; when both are absent, use the known actual form-filling user. The discharging user is not automatically the author. Use UZCorePractitioner directly when identity is known but role is not; do not invent a profession. Provenance/attestation follows Form 066; the DHP attester does not replace the clinical author. UZCoreProvenance allows a Bundle document target, not Composition.
- The supplied frontend description blocks editing after hospitalization completion. The revision transport contract does not imply a post-discharge edit button. Printing a saved revision does not create clinical facts. Historical pregnancy counts must not be calculated from the current delivery.

### Composition sections

All 13 named coded slices below are optional (0..1). Epidemiological history is an additional optional open section with source text and no fixed coded discriminator. Base FHIR section-content invariants still apply; omit a section without content instead of inventing entries.

| Slice | Section code | Permitted entries |
|---|---|---|
| `admissionInformation` | `LOINC#46241-6` | `UZCorePatient or UZCoreEncounter or UZCoreOrganization or UZCoreObservation or UZCoreCondition or UZCoreProcedure or UZCoreAllergyIntolerance` |
| `medicalAndObstetricHistory` | `LOINC#11329-0` | `UZCoreRelatedPerson or UZCoreObservation or UZCoreCondition or Procedure or UZCoreQuestionnaireResponse` |
| `currentPregnancy` | `LOINC#65869-0` | `UZCoreObservation or UZCoreCondition or UZCoreQuestionnaireResponse` |
| `obstetricExamination` | `SCT#163497009` | `UZCoreObservation or UZCorePractitionerRole` |
| `laborCourse` | `SCT#289909005` | `UZCoreObservation or Procedure or MedicationAdministration or UZCorePractitionerRole` |
| `newbornDeliveryRecord` | `LOINC#57075-4` | `UZCorePatient or UZCoreObservation or UZCoreCondition or Procedure or Immunization or UZCorePractitionerRole` |
| `postpartumPeriod` | `LOINC#11506-3` | `UZCoreObservation` |
| `medicationOrders` | `LOINC#10160-0` | `MedicationRequest or MedicationAdministration or UZCoreObservation` |
| `diagnosticOrders` | `LOINC#18776-5` | `UZCoreServiceRequest or UZCoreObservation` |
| `procedureOrders` | `LOINC#29554-3` | `UZCoreServiceRequest or Procedure` |
| `usedMaterials` | `LOINC#46264-8` | `SupplyDelivery` |
| `sickLeaveCertificates` | `SCT#224459001` | `SickLeaveCarePlan` |
| `responsiblePersons` | `LOINC#51899-3` | `UZCorePractitionerRole or Provenance` |

### Code systems and identifiers

Coding systems, unit systems and identifier namespaces are distinct. A ValueSet URL is not a Coding.system. Integration CS/VS links point to definitions in this branch; their existence is not approval or deployment. Do not invent an international mapping from an ambiguous source label.

| Name | URI |
|---|---|
| `LOINC` | `http://loinc.org` |
| `SCT` | `http://snomed.info/sct` |
| `UCUM` | `http://unitsofmeasure.org` |
| `ICD-10` | `http://hl7.org/fhir/sid/icd-10` |
| `ICHI` | `http://id.who.int/icd/release/11/ichi` |
| `v3-MaritalStatus` | `http://terminology.hl7.org/CodeSystem/v3-MaritalStatus` |
| `discharge-disposition` | `http://terminology.hl7.org/CodeSystem/discharge-disposition` |
| `Core home CS` | `https://terminology.dhp.uz/fhir/core/CodeSystem/encounter-discharge-disposition-home-cs` |
| `diagnosis-type-cs` | `https://terminology.dhp.uz/fhir/core/CodeSystem/diagnosis-type-cs` |
| `location-kinds-cs` | `https://terminology.dhp.uz/fhir/core/CodeSystem/location-kinds-cs` |
| `HC` | `https://dhp.uz/fhir/core/sid/pid/uz/hc` |
| `NI` | `https://dhp.uz/fhir/core/sid/pid/uz/ni` |
| `Core soliq identifier` | `https://dhp.uz/fhir/core/sid/org/uz/soliq` |
| `medical-record-number` | `https://dhp.uz/fhir/core/sid/doc/uz/medical-record-number` |
| `form-number` | `https://dhp.uz/fhir/core/sid/doc/uz/form-number` |
| `location-unit` | `https://dhp.uz/fhir/core/NamingSystem/location-unit` |
| `UUID URI identifier` | `urn:ietf:rfc:3986` |

[maternal-pelvimetry-measurement-code-cs](CodeSystem-maternal-pelvimetry-measurement-code-cs.html); [fetal-lie-vs](ValueSet-fetal-lie-vs.html); [fetal-presentation-vs](ValueSet-fetal-presentation-vs.html); [abo-blood-group-vs](ValueSet-abo-blood-group-vs.html); [rh-factor-vs](ValueSet-rh-factor-vs.html); [maternal-death-timing-vs](ValueSet-maternal-death-timing-vs.html); [amniotic-fluid-characteristic-vs](ValueSet-amniotic-fluid-characteristic-vs.html).

### Document and patient identity

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Hujjat identifikatori | Идентификатор документа | `Composition.identifier; Bundle.identifier`<br/>DMED source: `data.id; document revision context` | `urn:ietf:rfc:3986` | urn:uuid:… |
| Shakl raqami | Номер формы | `Composition.identifier` | `form-number` | 096 |
| Tibbiy karta raqami | Номер медкарты пациентки | `Patient.identifier[healthCardId]`<br/>DMED source: `data.patient.number_med_card` | `HC` | MED-096-0001 |
| JShShIR | ПИНФЛ | `Patient.identifier[nationalId]` | `NI` | 14 digits, when available |
| Bemor F.I.Sh. | ФИО пациентки | `Patient.name.text; family; given`<br/>DMED source: `data.patient.name` | `—` | Synthetic patient |
| Tug‘ilgan sana | Дата рождения | `Patient.birthDate` | `—` | 1990-04-12 |
| Millati | Национальность | `Patient.extension[nationality].extension[code].valueCodeableConcept`<br/>DMED source: `data.nationality` | `Core nationality-cs` | source code |
| Yashash manzili | Адрес проживания | `Patient.address`<br/>DMED source: `data.patient.place_residence` | `Core address-use rules` | source address |
| Ro‘yxatdan o‘tgan manzil | Адрес регистрации | `Patient.address`<br/>DMED source: `data.patient.place_registration` | `Core address-use rules` | source address |
| Oilaviy holati | Семейное положение | `Patient.maritalStatus`<br/>DMED source: `data.patient.family_status` | `v3-MaritalStatus#M` | married |
| Telefon | Телефон | `Patient.telecom` | `system = phone` | source telephone |
| Tibbiy muassasa STIRi | ИНН медицинской организации | `Organization.identifier[taxId]` | `Core soliq identifier` | 999999999 |
{: .mapping-fields}

### Maternal hospitalization, discharge and death

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Kasallik tarixi raqami | Номер истории болезни | `Encounter.identifier`<br/>DMED source: `data.hospitalization_id` | `medical-record-number` | 20676 |
| Qabul qilingan sana va vaqt | Дата и время поступления | `Encounter.actualPeriod.start`<br/>DMED source: `data.hospitalization.start_at` | `—` | 2026-08-30T09:15:00+05:00 |
| Chiqarilgan sana va vaqt | Дата и время выписки | `Encounter.actualPeriod.end` | `—` | source date/time |
| Palata | Палата | `Encounter.location.location → Location.identifier[unit]`<br/>DMED source: `data.hospitalization.chamber` | `location-kinds-cs#Ward` | 12 |
| Yo‘llagan muassasa | Направившая организация | `Encounter.admission.origin → Organization.name`<br/>DMED source: `data.hospitalization.sending_clinic.title` | `—` | source organization |
| Chiqarildi | Выписана | `Encounter.admission.dischargeDisposition` | `Core home CS#mserv-0004-00004` | discharged |
| Boshqa muassasaga o‘tkazildi | Переведена | `Encounter.admission.dischargeDisposition` | `discharge-disposition#other-hcf` | transferred |
| Vafot etdi | Умерла | `Encounter.admission.dischargeDisposition` | `discharge-disposition#exp` | died |
| O‘tkazilgan muassasa | Учреждение перевода | `Encounter.admission.destination → Organization.identifier[taxId]`<br/>DMED source: `data.pregnancy_birth.clinic.inn` | `Core soliq identifier` | 999999999 |
| O‘lim sanasi va vaqti | Дата и время смерти | `Patient.deceasedDateTime`<br/>DMED source: `postmortem epicrisis; API selector pending` | `—` | source precision |
| O‘lim ma’lum, sana noma’lum | Смерть известна, дата неизвестна | `Patient.deceasedBoolean` | `—` | true |
| Ona o‘limining davri | Период смерти матери | `Observation.component.valueCodeableConcept`<br/>DMED source: `data.pregnancy_birth.death_time` | `maternal-death-timing-vs; mapping pending` | omit until source meaning verified |
{: .mapping-fields}

### Diagnoses and operations

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Qabul tashxisi | Поступной диагноз | `Condition.code; Encounter.diagnosis.condition`<br/>DMED source: `data.admission_diagnosis.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00002` | O26.9 |
| Klinik tashxis | Клинический диагноз | `Condition.code; Encounter.diagnosis.use.text`<br/>DMED source: `data.disease_codes[source=hospitalization, type=main].disease_code.code` | `ICD-10; source role text` | O14.1 |
| Yakuniy tashxis | Окончательный диагноз | `Condition.code; Condition.extension[diagnosisType]`<br/>DMED source: `data.disease_codes[source=medical_case, type=main].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00003` | O80 |
| Asoratlar | Осложнения | `Condition.code; Condition.extension[diagnosisType]`<br/>DMED source: `data.disease_codes[*].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00005` | source diagnosis |
| Hamroh kasalliklar | Сопутствующие заболевания | `Condition.code; Condition.extension[diagnosisType]` | `ICD-10; diagnosis-type-cs#gencl-0001-00004` | source diagnosis |
| Operatsiya | Операция | `Procedure.code; occurrence[x]; performer.actor`<br/>DMED source: `data.surgical_interventions[*].ichi.title; performed_at` | `ICHI if supplied; otherwise code.text` | source operation title |
{: .mapping-fields}

### History, allergy, blood group and pregnancy

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Oldingi kasalliklar va operatsiyalar | Перенесённые болезни и операции | `Condition; Procedure` | `verified source codes or source text` | source history |
| Akusherlik va epidemiologik anamnez | Акушерский и эпидемиологический анамнез | `QuestionnaireResponse.item.answer` | `form-096-history Questionnaire` | source answers |
| Turmush o‘rtog‘i haqida | Сведения о супруге | `RelatedPerson; clinical facts with the correct subject` | `verified relationship code` | source data |
| Allergiya | Аллергия | `AllergyIntolerance.code; reaction`<br/>DMED source: `data.allergies[]` | `verified source code or text` | source allergy |
| Ma’lum allergiya yo‘q | Явно указано отсутствие известных аллергий | `AllergyIntolerance.code` | `SCT#716186003` | only an explicit negative history |
| Qon guruhi | Группа крови матери | `Observation.code → valueCodeableConcept`<br/>DMED source: `data.patient_detail.blood_type` | `LOINC#883-9; abo-blood-group-vs` | A / II |
| Rezus omil | Резус-фактор матери | `Observation.code → valueCodeableConcept`<br/>DMED source: `data.patient_detail.rh_factor` | `LOINC#10331-7; rh-factor-vs` | positive |
| Homiladorlikdagi ko‘riklar soni | Количество осмотров во время беременности | `Observation.code → valueInteger`<br/>DMED source: `data.pregnancy_progress_count` | `LOINC#68493-6` | 6 |
| Homiladorliklar soni | Количество беременностей | `Observation.code → valueInteger`<br/>DMED source: `data.birth_protocol.total_pregnancies` | `LOINC#11996-6` | 4 |
| Tug‘ruqlar soni | Количество родов / паритет | `Observation.code → valueInteger`<br/>DMED source: `data.birth_protocol.total_births` | `LOINC#11977-6` | 2 |
| Oxirgi hayz sanasi | Дата последней менструации | `Observation.code → valueDateTime`<br/>DMED source: `data.last_menstruation` | `LOINC#8665-2` | 2025-12-01 |
| Homilaning birinchi qimirlashi | Дата первого шевеления | `Observation.code → valueDateTime`<br/>DMED source: `data.first_fetal_movement` | `LOINC#57065-5` | 2026-04-10 |
{: .mapping-fields}

### Maternal measurements and pelvimetry

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Bo‘yi | Рост матери | `Observation.code → valueQuantity`<br/>DMED source: `data.hospitalization.height` | `LOINC#8302-2; UCUM cm` | 168 cm |
| Vazni | Вес матери | `Observation.code → valueQuantity`<br/>DMED source: `data.hospitalization.weight` | `LOINC#29463-7; UCUM kg` | 72.4 kg |
| Tana harorati | Температура | `Observation.code → valueQuantity`<br/>DMED source: `data.hospitalization.temperature` | `LOINC#8310-5; UCUM Cel` | 36.8 Cel |
| D. spinarum | D. spinarum | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0001; UCUM cm` | 25 cm |
| D. cristarum | D. cristarum | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0002; UCUM cm` | 28 cm |
| D. trochanterica | D. trochanterica | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0003; UCUM cm` | 31 cm |
| C. externa | C. externa | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0004; UCUM cm` | 20 cm |
| C. diagonalis | C. diagonalis | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `SCT#249011002; UCUM cm` | 12.5 cm |
| C. vera | C. vera | `Observation.code → valueQuantity`<br/>DMED source: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0006; UCUM cm` | 11 cm |
| Qorin aylanasi | Обхват живота | `Observation.code → valueQuantity`<br/>DMED source: `data.abdominal_circumference` | `LOINC#8280-0; UCUM cm` | 98 cm |
| Bachadon tubi balandligi | Высота дна матки | `Observation.code → valueQuantity`<br/>DMED source: `data.uterine_fundus_height` | `LOINC#11881-0; UCUM cm` | 32 cm |
{: .mapping-fields}

### Fetal assessment

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Homilaning yotishi | Положение плода | `Observation.component.code → valueCodeableConcept`<br/>DMED source: `data.fetal_position` | `LOINC#11874-5; fetal-lie-vs` | longitudinal |
| Homilaning pozitsiyasi va turi | Позиция и вид плода | `Observation.component.code.text → valueCodeableConcept.text` | `exact source text; mapping pending` | source description |
| Homila yurak urishi | Сердцебиение плода | `Observation.component.code → valueQuantity or valueInteger`<br/>DMED source: `data.fetal_heartbeat` | `LOINC#55283-6; UCUM /min for Quantity` | 145 /min |
| Yurak tovushlari eshitiladigan joy | Место выслушивания сердцебиения | `Observation.component.code.text → valueString` | `source text` | source location |
| Homilaning oldinda kelishi | Предлежание плода | `Observation.component.code → valueCodeableConcept`<br/>DMED source: `data.fetal_presentation` | `LOINC#11877-8; fetal-presentation-vs` | cephalic |
| Homilaning taxminiy vazni | Предполагаемый вес плода | `Observation.component.code → valueQuantity`<br/>DMED source: `data.estimated_fetal_weight` | `LOINC#11727-5; UCUM g` | 3100 g |
{: .mapping-fields}

### Labor and amniotic fluid

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Tug‘ruqning boshlanishi va tugashi | Начало и окончание родового процесса | `Observation.effectivePeriod`<br/>DMED source: `source protocol timestamps` | `SCT#386216000` | actual known interval |
| Qog‘onoq pufagi yorilgan vaqt | Разрыв околоплодного пузыря | `Observation.component.code.text → valueDateTime` | `source label; no invented timestamp` | 2026-08-16T10:05:00+05:00 |
| Qog‘onoq suvlari | Характер околоплодных вод | `Observation.component.code → valueCodeableConcept` | `LOINC#1887-9; amniotic-fluid-characteristic-vs` | verified source value |
| I davr | I период | `Observation.component.code → valueQuantity` | `SCT#6893006; UCUM min` | 355 min |
| II davr | II период | `Observation.component.code → valueQuantity` | `SCT#42857002; UCUM min` | 25 min |
| III davr | III период | `Observation.component.code → valueQuantity` | `SCT#15898009; UCUM min` | 10 min |
| Umumiy davomiylik | Общая длительность | `Observation.component.code → valueQuantity` | `SCT#271562002; UCUM min` | 390 min |
{: .mapping-fields}

### Individual newborn facts

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Har bir chaqaloq | Отдельный ребёнок | `Patient; Observation.subject`<br/>DMED source: `data.birth_protocol.newborn_children[*]` | `LOINC#57075-4 for delivery information` | one Patient per child |
| Chaqaloq tibbiy kartasi | HC ребёнка | `Patient.identifier[healthCardId]` | `HC` | distinct stable card number |
| Tug‘ilgan sana va vaqt | Дата и время рождения | `Patient.birthDate; birthTime extension; Observation.effectiveDateTime` | `Core birth-time rules` | source precision |
| Tirik tug‘ilish | Живорождение | `Observation.component.code → valueCodeableConcept`<br/>DMED source: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#281050002` | live_birth |
| O‘lik tug‘ilish | Мертворождение | `Observation.component.code → valueCodeableConcept`<br/>DMED source: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#237364002` | stillbirth |
| Antenatal o‘lim | Антенатальная гибель | `Condition.code; subject = child` | `SCT#237361005` | only when period is known |
| Intranatal o‘lim | Интранатальная гибель | `Condition.code; subject = child` | `SCT#237362003` | only when period is known |
| Tug‘ilgandagi vazn | Вес при рождении | `Observation.component.code → valueQuantity`<br/>DMED source: `data.birth_protocol.newborn_children[*].weight_in_grams` | `LOINC#8339-4; UCUM g` | 3250 g |
| Tug‘ilgandagi bo‘yi | Рост при рождении | `Observation.component.code → valueQuantity` | `LOINC#89269-5; UCUM cm` | 49 cm |
| Bosh aylanasi | Окружность головы | `Observation.component.code → valueQuantity` | `LOINC#9843-4; UCUM cm` | 34 cm |
| Ko‘krak aylanasi | Окружность груди | `Observation.component.code → valueQuantity` | `SCT#248366000; UCUM cm` | 32 cm |
| Apgar bahosi, 1-daqiqa | Апгар на 1-й минуте | `Observation.component.code → valueInteger`<br/>DMED source: `data.birth_protocol.newborn_children[*].apgar_score` | `LOINC#9272-6` | 8 |
| Tug‘ilgandan keyingi o‘lim | Смерть после живорождения | `Patient.deceased[x]; documented clinical fact`<br/>DMED source: `data.birth_protocol.newborn_children[*].postnatal_death` | `not Stillbirth` | source death date or true |
| Chaqaloqning chiqishi yoki o‘tkazilishi | Выписка или перевод ребёнка | `child Encounter.actualPeriod; admission.destination` | `child UZCoreEncounter` | source child event |
{: .mapping-fields}

### Current delivery counts and previous pregnancies

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Hozirgi tug‘ruqda tirik tug‘ilganlar | Живорождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `LOINC#73773-4` | 2 |
| Hozirgi tug‘ruqda o‘lik tug‘ilganlar | Мертворождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `SCT#252112002` | 0 |
| Oldingi homiladorliklar natijalari | Исходы предыдущих беременностей | `maternal Observation; source history` | `mapping pending` | omit if unavailable |
{: .mapping-fields}

### Placenta and postpartum observations

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Yo‘ldosh, pardalar va kindik | Послед, оболочки и пуповина | `Observation.component.value[x]` | `only reviewed indicator codes or source text` | source findings |
| Qon yo‘qotish | Кровопотеря | `Observation.component.code.text → valueQuantity` | `UCUM mL` | 320 mL |
| Yo‘ldosh ajralish usuli | Способ отделения последа | `Procedure.note.text` | `method is not Procedure.outcome` | source method |
| Tug‘ruqdan keyingi kuzatuv | Послеродовое наблюдение | `Observation.effectiveDateTime; component.value[x]` | `individual verified codes or source text` | one row per source assessment |
{: .mapping-fields}

### Orders, treatment and certificates

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Dori buyurilishi | Назначение лекарственного средства | `MedicationRequest.medication; dosageInstruction` | `verified medication code or source text` | source prescription |
| Dori yuborilishi | Введение лекарственного средства | `MedicationAdministration.medication; occurence[x]; dosage` | `verified medication code or source text` | source administration |
| Tekshiruv buyurilishi | Назначение исследования | `ServiceRequest.code; authoredOn` | `verified laboratory catalog` | source order |
| Tekshiruv natijasi | Результат исследования | `Observation.code; value[x]; effective[x]`<br/>DMED source: `data.pregnancy_birth.analyses[*]` | `verified LOINC; UCUM when applicable` | source result |
| Muolaja natijasi | Результат вмешательства | `Procedure.outcome` | `SCT#385669000 / 385670004 / 385671000` | explicit source outcome |
| Ishlatilgan materiallar | Использованные материалы | `SupplyDelivery.suppliedItem` | `verified source catalog` | source item and quantity |
| Mehnatga layoqatsizlik varaqasi | Больничный лист | `SickLeaveCarePlan` | `existing SickLeaveCarePlan profile` | source certificate |
{: .mapping-fields}

### Authors and provenance

| UZ | RU | FHIR Path / DMED source | Code | Example |
|---|---|---|---|---|
| Davolovchi shifokor | Лечащий врач госпитализации | `Encounter.participant.individual` | `PractitionerRole / Practitioner as permitted` | identified source clinician |
| Shakldagi shifokor va akusher | Врач и акушер в форме | `Composition.author; clinical performer references` | `UZCorePractitionerRole or UZCorePractitioner` | known source identity |
| Shaklni to‘ldirgan foydalanuvchi | Заполнивший форму пользователь | `Composition.author when both selected clinicians absent` | `identified source author` | not automatically the discharging user |
| Mas’ul muassasa | Организация документа | `Composition.custodian` | `UZCoreOrganization` | optional source organization |
| Saqlash vaqti va kelib chiqishi | Время сохранения и происхождение | `Composition.date; Provenance.recorded; agent` | `Form 066 workflow` | source revision timestamp |
{: .mapping-fields}

### Mappings awaiting source confirmation

- Laboratory catalog: obtain source IDs, definitions, methods/specimens and result types for WR I/II, HIV 1/2/rapid, blood count, HBsAg I/II, gonococcus, toxoplasmosis, urine, smear and stool. Do not choose an individual analyte or a method-specific LOINC from a broad UI label. Preserve free-text results until coding is established.
- Fetal presentation: the supplied UI has 13 options; the current draft ValueSet is not a complete source crosswalk. Resolve complete/incomplete/mixed labels before assigning a code. Fetal lie, presentation and the location of heart sounds are separate facts.
- Diagnosis roles and operations: obtain source dictionaries and the actual ICHI field or internal-ID lookup. A title is not a machine code. Target Core diagnosis roles use the diagnosis-type extension; legacy Condition.category roles in the example are not the final DMED crosswalk. Clinical diagnosis does not automatically mean working or confirmed.
- Maternal death timing is a category, not a timestamp. A reported mismatch of UI labels has not been independently verified: obtain selected label → API value → intended meaning. Omit a timing value whose meaning is unknown; death date is independent.
- Historical living/stillborn/deceased-child counts are not inferred from this delivery. Current-delivery counts need explicit source context; postnatal-death counting still needs a defined observation period. Confirm HC issuance, uniqueness and stability for every child, including stillbirths. Accepting a snapshot does not prove creation of a searchable master Patient.
- Exact API selectors remain pending for six pelvic measurements, some author fields and precise death/event timestamps. A UI field or synthetic Bundle does not prove a JSON selector. Resolve the ambiguous Rh label and overlapping fetal-heart fields before mapping their raw values.

### Bundle structure and examples

```text
Bundle (document; revision identity)
  Composition (Form 096; stable source document identity)
    subject -> mother Patient
    encounter -> maternal UZ Core Encounter shared with Form 066
    author -> identified PractitionerRole / Practitioner
    section[0..*] -> available clinical resources only
  Patient (mother)
  Encounter (maternal snapshot)
  Patient (one per newborn; stable HC identity)
  Observation / Condition / Procedure (correct maternal or child subject)
  Organization / Location / Practitioner / PractitionerRole as needed
  QuestionnaireResponse / orders / treatment / certificates when available
  Provenance according to the Form 066 workflow
```

- [Complete synthetic document](Bundle-example-form-096-maternity-medical-record.html)
- [Antepartum stillbirth](Bundle-example-form-096-antepartum-stillbirth.html)
- [Intrapartum stillbirth](Bundle-example-form-096-intrapartum-stillbirth.html)
- [Minimal clinical document](Bundle-example-form-096-minimal.html)
- [Author without a known role](Bundle-example-form-096-author-without-role.html)
