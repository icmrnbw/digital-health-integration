<style>
.col-12 table.mapping-fields { table-layout: fixed; width: 100%; }
.col-12 .mapping-fields th, .col-12 .mapping-fields td { overflow-wrap: anywhere; word-break: break-word; vertical-align: top; }
.col-12 .mapping-fields th:nth-child(1), .col-12 .mapping-fields td:nth-child(1) { width: 17%; }
.col-12 .mapping-fields th:nth-child(2), .col-12 .mapping-fields td:nth-child(2) { width: 20%; }
.col-12 .mapping-fields th:nth-child(3), .col-12 .mapping-fields td:nth-child(3) { width: 28%; }
.col-12 .mapping-fields th:nth-child(4), .col-12 .mapping-fields td:nth-child(4) { width: 23%; }
.col-12 .mapping-fields th:nth-child(5), .col-12 .mapping-fields td:nth-child(5) { width: 12%; }
</style>

### Форма 096 — история родов: маппинг полей

### Обзор

Страница сопоставляет поддерживаемые поля формы 096 и предоставленные данные DMED с FHIR R5. Используются [Composition формы 096](StructureDefinition-form-096-maternity-medical-record-composition.html) и ресурсы UZ Core. [Полный синтетический документ](Bundle-example-form-096-maternity-medical-record.html) содержит расширенный набор данных; он не доказывает наличие каждого поля в DMED.

### Правила данных и идентичности

- Клинические факты и разделы необязательны по наличию. Недоступные ресурсы/компоненты пропускаются; достоверные 0 и false сохраняются. Обязательные метаданные и идентификаторы FHIR/Core остаются. Обязательность UI не добавляет минимумы интеграции.
- Используется механизм идентичности, фазы ресурсов и редакций 066. У матери один общий мастер-Encounter для 066/096; каждый документ хранит исторический снимок. POST документа сам по себе не обновляет мастер-ресурсы. Стабильная бизнес-идентичность отличается от идентичности редакции Bundle. UUID-примеры используют urn:ietf:rfc:3986; form-number со значением 096 не является уникальным ID карты.
- Большинство измерений — отдельные Observation матери. Явные пути component описывают поддерживаемые клинические компоненты полного примера; один факт не передаётся дважды. Субъект индивидуальных данных рождения — ребёнок. Общие факты родов/последа сохраняют мать, её Encounter и стабильные ID фактов в 096/097. У ребёнка собственная госпитализация.
- Исход рождения: LOINC 63893-2 → SCT 281050002 Livebirth или 237364002 Stillbirth. Известный антенатальный/интранатальный период — отдельный Condition ребёнка, 237361005/237362003. Смерть после живорождения не меняет исход рождения. При известной дате используется Patient.deceasedDateTime, при известном факте без даты — deceasedBoolean=true; обновляется и мастер-Patient, и снимок.
- Приходящий Апгар — итог на 1-й минуте, 9272-6. Пятая минута и компоненты не выдумываются. UI требует оценку и при мертворождении: нужно подтвердить, является ли полученное значение реальной оценкой; отсутствие не заменяется нулём. Длительности — UCUM min: 01:30 означает 90 минут. Отсутствующий III не равен нулю; сумма I–II не является полной I–III. Конец трёх периодов не равен рождению последнего ребёнка. Точность исходной даты сохраняется.
- Пельвиометрия — шесть отдельных Observation матери. C. diagonalis использует SCT 249011002. C. vera не заменяется кодом акушерской конъюгаты без подтверждения смысла. Исход матери использует binding Core Encounter; учреждение перевода — admission.destination. Способ отделения последа не является Procedure.outcome.
- Авторы 096 — указанные врач/акушер; при отсутствии обоих передаётся известный фактический пользователь заполнения. Выписавший не становится автором автоматически. Если личность известна, а роль нет, допускается UZCorePractitioner; профессия не выдумывается. Provenance/аттестация — по механизму 066; агент DHP не заменяет клинического автора. UZCoreProvenance допускает целью документа Bundle, а не Composition.
- По предоставленному описанию фронтенда после завершения госпитализации правка заблокирована. Поддержка редакций при отправке не означает наличия кнопки правки после выписки. Печать сохранённой редакции не создаёт факты. Анамнестические счётчики не рассчитываются из текущих родов.

### Разделы Composition

Все 13 именованных кодированных срезов ниже необязательны (0..1). Эпидемиологический анамнез — дополнительная открытая необязательная секция с исходным текстом без фиксированного кодированного дискриминатора. Базовые инварианты содержимого секций FHIR сохраняются; раздел без содержимого пропускается вместо выдуманных записей.

| Срез | Код раздела | Разрешённые записи |
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

### Системы кодов и идентификаторы

Системы кодов, единиц и пространства идентификаторов различаются. ValueSet URL не является Coding.system. Ссылки на CS/VS Integrations ведут к определениям этой ветки; их наличие не доказывает согласование и развёртывание. Неоднозначные подписи источника не превращаются в международные коды по догадке.

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

### Идентичность документа и пациентки

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Hujjat identifikatori | Идентификатор документа | `Composition.identifier; Bundle.identifier`<br/>Источник DMED: `data.id; document revision context` | `urn:ietf:rfc:3986` | urn:uuid:… |
| Shakl raqami | Номер формы | `Composition.identifier` | `form-number` | 096 |
| Tibbiy karta raqami | Номер медкарты пациентки | `Patient.identifier[healthCardId]`<br/>Источник DMED: `data.patient.number_med_card` | `HC` | MED-096-0001 |
| JShShIR | ПИНФЛ | `Patient.identifier[nationalId]` | `NI` | 14 digits, when available |
| Bemor F.I.Sh. | ФИО пациентки | `Patient.name.text; family; given`<br/>Источник DMED: `data.patient.name` | `—` | Synthetic patient |
| Tug‘ilgan sana | Дата рождения | `Patient.birthDate` | `—` | 1990-04-12 |
| Millati | Национальность | `Patient.extension[nationality].extension[code].valueCodeableConcept`<br/>Источник DMED: `data.nationality` | `Core nationality-cs` | source code |
| Yashash manzili | Адрес проживания | `Patient.address`<br/>Источник DMED: `data.patient.place_residence` | `Core address-use rules` | source address |
| Ro‘yxatdan o‘tgan manzil | Адрес регистрации | `Patient.address`<br/>Источник DMED: `data.patient.place_registration` | `Core address-use rules` | source address |
| Oilaviy holati | Семейное положение | `Patient.maritalStatus`<br/>Источник DMED: `data.patient.family_status` | `v3-MaritalStatus#M` | married |
| Telefon | Телефон | `Patient.telecom` | `system = phone` | source telephone |
| Tibbiy muassasa STIRi | ИНН медицинской организации | `Organization.identifier[taxId]` | `Core soliq identifier` | 999999999 |
{: .mapping-fields}

### Госпитализация матери, выписка и смерть

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Kasallik tarixi raqami | Номер истории болезни | `Encounter.identifier`<br/>Источник DMED: `data.hospitalization_id` | `medical-record-number` | 20676 |
| Qabul qilingan sana va vaqt | Дата и время поступления | `Encounter.actualPeriod.start`<br/>Источник DMED: `data.hospitalization.start_at` | `—` | 2026-08-30T09:15:00+05:00 |
| Chiqarilgan sana va vaqt | Дата и время выписки | `Encounter.actualPeriod.end` | `—` | source date/time |
| Palata | Палата | `Encounter.location.location → Location.identifier[unit]`<br/>Источник DMED: `data.hospitalization.chamber` | `location-kinds-cs#Ward` | 12 |
| Yo‘llagan muassasa | Направившая организация | `Encounter.admission.origin → Organization.name`<br/>Источник DMED: `data.hospitalization.sending_clinic.title` | `—` | source organization |
| Chiqarildi | Выписана | `Encounter.admission.dischargeDisposition` | `Core home CS#mserv-0004-00004` | discharged |
| Boshqa muassasaga o‘tkazildi | Переведена | `Encounter.admission.dischargeDisposition` | `discharge-disposition#other-hcf` | transferred |
| Vafot etdi | Умерла | `Encounter.admission.dischargeDisposition` | `discharge-disposition#exp` | died |
| O‘tkazilgan muassasa | Учреждение перевода | `Encounter.admission.destination → Organization.identifier[taxId]`<br/>Источник DMED: `data.pregnancy_birth.clinic.inn` | `Core soliq identifier` | 999999999 |
| O‘lim sanasi va vaqti | Дата и время смерти | `Patient.deceasedDateTime`<br/>Источник DMED: `postmortem epicrisis; API selector pending` | `—` | source precision |
| O‘lim ma’lum, sana noma’lum | Смерть известна, дата неизвестна | `Patient.deceasedBoolean` | `—` | true |
| Ona o‘limining davri | Период смерти матери | `Observation.component.valueCodeableConcept`<br/>Источник DMED: `data.pregnancy_birth.death_time` | `maternal-death-timing-vs; mapping pending` | omit until source meaning verified |
{: .mapping-fields}

### Диагнозы и операции

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Qabul tashxisi | Поступной диагноз | `Condition.code; Encounter.diagnosis.condition`<br/>Источник DMED: `data.admission_diagnosis.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00002` | O26.9 |
| Klinik tashxis | Клинический диагноз | `Condition.code; Encounter.diagnosis.use.text`<br/>Источник DMED: `data.disease_codes[source=hospitalization, type=main].disease_code.code` | `ICD-10; source role text` | O14.1 |
| Yakuniy tashxis | Окончательный диагноз | `Condition.code; Condition.extension[diagnosisType]`<br/>Источник DMED: `data.disease_codes[source=medical_case, type=main].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00003` | O80 |
| Asoratlar | Осложнения | `Condition.code; Condition.extension[diagnosisType]`<br/>Источник DMED: `data.disease_codes[*].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00005` | source diagnosis |
| Hamroh kasalliklar | Сопутствующие заболевания | `Condition.code; Condition.extension[diagnosisType]` | `ICD-10; diagnosis-type-cs#gencl-0001-00004` | source diagnosis |
| Operatsiya | Операция | `Procedure.code; occurrence[x]; performer.actor`<br/>Источник DMED: `data.surgical_interventions[*].ichi.title; performed_at` | `ICHI if supplied; otherwise code.text` | source operation title |
{: .mapping-fields}

### Анамнез, аллергии, группа крови и беременность

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Oldingi kasalliklar va operatsiyalar | Перенесённые болезни и операции | `Condition; Procedure` | `verified source codes or source text` | source history |
| Akusherlik va epidemiologik anamnez | Акушерский и эпидемиологический анамнез | `QuestionnaireResponse.item.answer` | `form-096-history Questionnaire` | source answers |
| Turmush o‘rtog‘i haqida | Сведения о супруге | `RelatedPerson; clinical facts with the correct subject` | `verified relationship code` | source data |
| Allergiya | Аллергия | `AllergyIntolerance.code; reaction`<br/>Источник DMED: `data.allergies[]` | `verified source code or text` | source allergy |
| Ma’lum allergiya yo‘q | Явно указано отсутствие известных аллергий | `AllergyIntolerance.code` | `SCT#716186003` | only an explicit negative history |
| Qon guruhi | Группа крови матери | `Observation.code → valueCodeableConcept`<br/>Источник DMED: `data.patient_detail.blood_type` | `LOINC#883-9; abo-blood-group-vs` | A / II |
| Rezus omil | Резус-фактор матери | `Observation.code → valueCodeableConcept`<br/>Источник DMED: `data.patient_detail.rh_factor` | `LOINC#10331-7; rh-factor-vs` | positive |
| Homiladorlikdagi ko‘riklar soni | Количество осмотров во время беременности | `Observation.code → valueInteger`<br/>Источник DMED: `data.pregnancy_progress_count` | `LOINC#68493-6` | 6 |
| Homiladorliklar soni | Количество беременностей | `Observation.code → valueInteger`<br/>Источник DMED: `data.birth_protocol.total_pregnancies` | `LOINC#11996-6` | 4 |
| Tug‘ruqlar soni | Количество родов / паритет | `Observation.code → valueInteger`<br/>Источник DMED: `data.birth_protocol.total_births` | `LOINC#11977-6` | 2 |
| Oxirgi hayz sanasi | Дата последней менструации | `Observation.code → valueDateTime`<br/>Источник DMED: `data.last_menstruation` | `LOINC#8665-2` | 2025-12-01 |
| Homilaning birinchi qimirlashi | Дата первого шевеления | `Observation.code → valueDateTime`<br/>Источник DMED: `data.first_fetal_movement` | `LOINC#57065-5` | 2026-04-10 |
{: .mapping-fields}

### Измерения матери и пельвиометрия

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Bo‘yi | Рост матери | `Observation.code → valueQuantity`<br/>Источник DMED: `data.hospitalization.height` | `LOINC#8302-2; UCUM cm` | 168 cm |
| Vazni | Вес матери | `Observation.code → valueQuantity`<br/>Источник DMED: `data.hospitalization.weight` | `LOINC#29463-7; UCUM kg` | 72.4 kg |
| Tana harorati | Температура | `Observation.code → valueQuantity`<br/>Источник DMED: `data.hospitalization.temperature` | `LOINC#8310-5; UCUM Cel` | 36.8 Cel |
| D. spinarum | D. spinarum | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0001; UCUM cm` | 25 cm |
| D. cristarum | D. cristarum | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0002; UCUM cm` | 28 cm |
| D. trochanterica | D. trochanterica | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0003; UCUM cm` | 31 cm |
| C. externa | C. externa | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0004; UCUM cm` | 20 cm |
| C. diagonalis | C. diagonalis | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `SCT#249011002; UCUM cm` | 12.5 cm |
| C. vera | C. vera | `Observation.code → valueQuantity`<br/>Источник DMED: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0006; UCUM cm` | 11 cm |
| Qorin aylanasi | Обхват живота | `Observation.code → valueQuantity`<br/>Источник DMED: `data.abdominal_circumference` | `LOINC#8280-0; UCUM cm` | 98 cm |
| Bachadon tubi balandligi | Высота дна матки | `Observation.code → valueQuantity`<br/>Источник DMED: `data.uterine_fundus_height` | `LOINC#11881-0; UCUM cm` | 32 cm |
{: .mapping-fields}

### Оценка плода

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Homilaning yotishi | Положение плода | `Observation.component.code → valueCodeableConcept`<br/>Источник DMED: `data.fetal_position` | `LOINC#11874-5; fetal-lie-vs` | longitudinal |
| Homilaning pozitsiyasi va turi | Позиция и вид плода | `Observation.component.code.text → valueCodeableConcept.text` | `exact source text; mapping pending` | source description |
| Homila yurak urishi | Сердцебиение плода | `Observation.component.code → valueQuantity or valueInteger`<br/>Источник DMED: `data.fetal_heartbeat` | `LOINC#55283-6; UCUM /min for Quantity` | 145 /min |
| Yurak tovushlari eshitiladigan joy | Место выслушивания сердцебиения | `Observation.component.code.text → valueString` | `source text` | source location |
| Homilaning oldinda kelishi | Предлежание плода | `Observation.component.code → valueCodeableConcept`<br/>Источник DMED: `data.fetal_presentation` | `LOINC#11877-8; fetal-presentation-vs` | cephalic |
| Homilaning taxminiy vazni | Предполагаемый вес плода | `Observation.component.code → valueQuantity`<br/>Источник DMED: `data.estimated_fetal_weight` | `LOINC#11727-5; UCUM g` | 3100 g |
{: .mapping-fields}

### Течение родов и околоплодные воды

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Tug‘ruqning boshlanishi va tugashi | Начало и окончание родового процесса | `Observation.effectivePeriod`<br/>Источник DMED: `source protocol timestamps` | `SCT#386216000` | actual known interval |
| Qog‘onoq pufagi yorilgan vaqt | Разрыв околоплодного пузыря | `Observation.component.code.text → valueDateTime` | `source label; no invented timestamp` | 2026-08-16T10:05:00+05:00 |
| Qog‘onoq suvlari | Характер околоплодных вод | `Observation.component.code → valueCodeableConcept` | `LOINC#1887-9; amniotic-fluid-characteristic-vs` | verified source value |
| I davr | I период | `Observation.component.code → valueQuantity` | `SCT#169821004; UCUM min` | 355 min |
| II davr | II период | `Observation.component.code → valueQuantity` | `SCT#169822006; UCUM min` | 25 min |
| III davr | III период | `Observation.component.code → valueQuantity` | `SCT#169823001; UCUM min` | 10 min |
| Umumiy davomiylik | Общая длительность | `Observation.component.code → valueQuantity` | `SCT#271562002; UCUM min` | 390 min |
{: .mapping-fields}

### Индивидуальные сведения о ребёнке

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Har bir chaqaloq | Отдельный ребёнок | `Patient; Observation.subject`<br/>Источник DMED: `data.birth_protocol.newborn_children[*]` | `LOINC#57075-4 for delivery information` | one Patient per child |
| Chaqaloq tibbiy kartasi | HC ребёнка | `Patient.identifier[healthCardId]` | `HC` | distinct stable card number |
| Tug‘ilgan sana va vaqt | Дата и время рождения | `Patient.birthDate; birthTime extension; Observation.effectiveDateTime` | `Core birth-time rules` | source precision |
| Tirik tug‘ilish | Живорождение | `Observation.component.code → valueCodeableConcept`<br/>Источник DMED: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#281050002` | live_birth |
| O‘lik tug‘ilish | Мертворождение | `Observation.component.code → valueCodeableConcept`<br/>Источник DMED: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#237364002` | stillbirth |
| Antenatal o‘lim | Антенатальная гибель | `Condition.code; subject = child` | `SCT#237361005` | only when period is known |
| Intranatal o‘lim | Интранатальная гибель | `Condition.code; subject = child` | `SCT#237362003` | only when period is known |
| Tug‘ilgandagi vazn | Вес при рождении | `Observation.component.code → valueQuantity`<br/>Источник DMED: `data.birth_protocol.newborn_children[*].weight_in_grams` | `LOINC#8339-4; UCUM g` | 3250 g |
| Tug‘ilgandagi bo‘yi | Рост при рождении | `Observation.component.code → valueQuantity` | `LOINC#89269-5; UCUM cm` | 49 cm |
| Bosh aylanasi | Окружность головы | `Observation.component.code → valueQuantity` | `LOINC#9843-4; UCUM cm` | 34 cm |
| Ko‘krak aylanasi | Окружность груди | `Observation.component.code → valueQuantity` | `SCT#248366000; UCUM cm` | 32 cm |
| Apgar bahosi, 1-daqiqa | Апгар на 1-й минуте | `Observation.component.code → valueInteger`<br/>Источник DMED: `data.birth_protocol.newborn_children[*].apgar_score` | `LOINC#9272-6` | 8 |
| Tug‘ilgandan keyingi o‘lim | Смерть после живорождения | `Patient.deceased[x]; documented clinical fact`<br/>Источник DMED: `data.birth_protocol.newborn_children[*].postnatal_death` | `not Stillbirth` | source death date or true |
| Chaqaloqning chiqishi yoki o‘tkazilishi | Выписка или перевод ребёнка | `child Encounter.actualPeriod; admission.destination` | `child UZCoreEncounter` | source child event |
{: .mapping-fields}

### Счётчики текущих родов и предыдущие беременности

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Hozirgi tug‘ruqda tirik tug‘ilganlar | Живорождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `LOINC#73773-4` | 2 |
| Hozirgi tug‘ruqda o‘lik tug‘ilganlar | Мертворождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `SCT#252112002` | 0 |
| Oldingi homiladorliklar natijalari | Исходы предыдущих беременностей | `maternal Observation; source history` | [form111-previous-pregnancy-outcome-vs](ValueSet-form111-previous-pregnancy-outcome-vs.html) | omit if unavailable |
{: .mapping-fields}

### Послед и послеродовые наблюдения

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Yo‘ldosh, pardalar va kindik | Послед, оболочки и пуповина | `Observation.component.value[x]` | `only reviewed indicator codes or source text` | source findings |
| Qon yo‘qotish | Кровопотеря | `Observation.component.code.text → valueQuantity` | `UCUM mL` | 320 mL |
| Yo‘ldosh ajralish usuli | Способ отделения последа | `Procedure.note.text` | `method is not Procedure.outcome` | source method |
| Tug‘ruqdan keyingi kuzatuv | Послеродовое наблюдение | `Observation.effectiveDateTime; component.value[x]` | `individual verified codes or source text` | one row per source assessment |
{: .mapping-fields}

### Назначения, лечение и документы

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Dori buyurilishi | Назначение лекарственного средства | `MedicationRequest.medication; dosageInstruction` | `verified medication code or source text` | source prescription |
| Dori yuborilishi | Введение лекарственного средства | `MedicationAdministration.medication; occurence[x]; dosage` | `verified medication code or source text` | source administration |
| Tekshiruv buyurilishi | Назначение исследования | `ServiceRequest.code; authoredOn` | `verified laboratory catalog` | source order |
| Tekshiruv natijasi | Результат исследования | `Observation.code; value[x]; effective[x]`<br/>Источник DMED: `data.pregnancy_birth.analyses[*]` | `verified LOINC; UCUM when applicable` | source result |
| Muolaja natijasi | Результат вмешательства | `Procedure.outcome` | `SCT#385669000 / 385670004 / 385671000` | explicit source outcome |
| Ishlatilgan materiallar | Использованные материалы | `SupplyDelivery.suppliedItem` | `verified source catalog` | source item and quantity |
| Mehnatga layoqatsizlik varaqasi | Больничный лист | `SickLeaveCarePlan` | `existing SickLeaveCarePlan profile` | source certificate |
{: .mapping-fields}

### Авторы и происхождение

| UZ | RU | FHIR Path / Источник DMED | Code | Пример |
|---|---|---|---|---|
| Davolovchi shifokor | Лечащий врач госпитализации | `Encounter.participant.individual` | `PractitionerRole / Practitioner as permitted` | identified source clinician |
| Shakldagi shifokor va akusher | Врач и акушер в форме | `Composition.author; clinical performer references` | `UZCorePractitionerRole or UZCorePractitioner` | known source identity |
| Shaklni to‘ldirgan foydalanuvchi | Заполнивший форму пользователь | `Composition.author when both selected clinicians absent` | `identified source author` | not automatically the discharging user |
| Mas’ul muassasa | Организация документа | `Composition.custodian` | `UZCoreOrganization` | optional source organization |
| Saqlash vaqti va kelib chiqishi | Время сохранения и происхождение | `Composition.date; Provenance.recorded; agent` | `Form 066 workflow` | source revision timestamp |
{: .mapping-fields}

### Соответствия, ожидающие подтверждения источника

- Каталог анализов: нужны ID, определения, методы/материал и типы результатов для WR I/II, ВИЧ 1/2/экспресс, общего анализа крови, HBsAg I/II, гонококка, токсоплазмоза, мочи, мазка и кала. По общей подписи UI нельзя выбрать отдельный аналит или метод-специфичный LOINC. Свободный результат сохраняется текстом до согласования кодирования.
- Предлежание: в предоставленном UI 13 вариантов; текущий проект ValueSet не является полной таблицей исходных значений. Для подписей полное/неполное/смешанное нужны определения. Положение плода, предлежание и место выслушивания сердцебиения — разные факты.
- Роли диагнозов и операции: нужны исходные словари и фактическое поле ICHI либо связь с внутренним ID. Название не является машинным кодом. Целевые роли задаются расширением diagnosis-type Core; устаревшие роли Condition.category в примере не заменяют окончательную таблицу DMED. Клинический диагноз не означает автоматически working или confirmed.
- Период смерти матери категориальный, не дата/время. Сообщение о перепутанных подписях UI независимо не проверено: нужны выбранная подпись → значение API → ожидаемый смысл. Значение периода с неизвестным смыслом пропускается; дата смерти независима от него.
- Анамнестические количества живых, мертворождённых и умерших детей не выводятся из текущих родов. Текущие счётчики требуют явного контекста; для умерших после рождения нужно определить период учёта. Подтвердить выдачу, уникальность и стабильность HC всем детям, включая мертворождённых. Приём снимка не доказывает создание доступного для поиска мастер-Patient.
- Точные API-селекторы шести размеров таза, части полей авторства и точного времени смерти/событий требуют подтверждения. Поле UI или синтетический Bundle не доказывает конкретный JSON-селектор. До маппинга сырых значений уточнить неоднозначную подпись Rh и пересекающиеся поля сердцебиения.

### Структура Bundle и примеры

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

- [Полный синтетический документ](Bundle-example-form-096-maternity-medical-record.html)
- [Антенатальное мертворождение](Bundle-example-form-096-antepartum-stillbirth.html)
- [Интранатальное мертворождение](Bundle-example-form-096-intrapartum-stillbirth.html)
- [Минимум клинических данных](Bundle-example-form-096-minimal.html)
- [Автор без известной роли](Bundle-example-form-096-author-without-role.html)
