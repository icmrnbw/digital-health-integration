<style>
.col-12 table.mapping-fields { table-layout: fixed; width: 100%; }
.col-12 .mapping-fields th, .col-12 .mapping-fields td { overflow-wrap: anywhere; word-break: break-word; vertical-align: top; }
.col-12 .mapping-fields th:nth-child(1), .col-12 .mapping-fields td:nth-child(1) { width: 17%; }
.col-12 .mapping-fields th:nth-child(2), .col-12 .mapping-fields td:nth-child(2) { width: 20%; }
.col-12 .mapping-fields th:nth-child(3), .col-12 .mapping-fields td:nth-child(3) { width: 28%; }
.col-12 .mapping-fields th:nth-child(4), .col-12 .mapping-fields td:nth-child(4) { width: 23%; }
.col-12 .mapping-fields th:nth-child(5), .col-12 .mapping-fields td:nth-child(5) { width: 12%; }
</style>

### 096-shakl — tug‘ruq tibbiy kartasi: maydonlar mosligi

### Umumiy ma’lumot

Sahifa 096-shaklning qo‘llab-quvvatlanadigan maydonlari va taqdim etilgan DMED ma’lumotlarini FHIR R5 bilan moslashtiradi. [096-shakl Composition](StructureDefinition-form-096-maternity-medical-record-composition.html) va UZ Core resurslari ishlatiladi. [To‘liq sun’iy hujjat](Bundle-example-form-096-maternity-medical-record.html) kengaytirilgan ma’lumotlarni ko‘rsatadi; bu har bir maydon DMED da mavjudligini isbotlamaydi.

### Ma’lumotlar va identifikatsiya qoidalari

- Klinik fakt va bo‘limlar mavjudligiga qarab ixtiyoriy. Mavjud bo‘lmagan resurs/komponent uzatilmaydi; haqiqiy 0 va false saqlanadi. FHIR/Core majburiy metama’lumotlari va identifikatorlari saqlanadi. UI majburiyligi yangi integratsiya minimumini yaratmaydi.
- 066 ning identifikatsiya, resurslar bosqichi va tahrir jarayoni ishlatiladi. Ona uchun 066/096 da bitta umumiy master-Encounter bor; har hujjat tarixiy nusxani saqlaydi. Hujjat POST so‘rovi master-resurslarni o‘z-o‘zidan yangilamaydi. Barqaror biznes-identifikatsiya Bundle tahriridan farq qiladi. UUID misollari urn:ietf:rfc:3986 dan foydalanadi; 096 qiymatli form-number noyob karta ID si emas.
- O‘lchovlarning ko‘pi onaning alohida Observation resurslari. Aniq component yo‘llari to‘liq misoldagi klinik komponentlarni bildiradi; bitta fakt ikki marta uzatilmaydi. Individual tug‘ilish faktlari subyekti bola. Umumiy tug‘ruq/yo‘ldosh faktlari 096/097 da ona, uning Encounter i va barqaror fakt ID sini saqlaydi. Bolaning o‘z gospitalizatsiyasi bor.
- Tug‘ilish natijasi: LOINC 63893-2 → SCT 281050002 Livebirth yoki 237364002 Stillbirth. Ma’lum antenatal/intranatal davr bolaning alohida Condition resursi, 237361005/237362003. Tirik tug‘ilgandan keyingi o‘lim tug‘ilish natijasini o‘zgartirmaydi. Sana ma’lum bo‘lsa Patient.deceasedDateTime, faqat fakt ma’lum bo‘lsa deceasedBoolean=true ishlatiladi; master-Patient va nusxa yangilanadi.
- Kelgan Apgar 1-daqiqadagi jami baho, 9272-6. 5-daqiqa yoki komponentlar o‘ylab topilmaydi. UI o‘lik tug‘ilishda ham baho talab qiladi: qiymat haqiqiy baholash ekanini tekshirish kerak; mavjud emaslik nol emas. Davomiylik UCUM min da: 01:30 — 90 daqiqa. Mavjud bo‘lmagan III nol emas; I–II yig‘indisi to‘liq I–III emas. Uch davr oxiri oxirgi bola tug‘ilishi emas. Manba sana aniqligi saqlanadi.
- Pelvimetriya onaning oltita alohida Observation resursida. C. diagonalis — SCT 249011002. C. vera ma’nosi tekshirilmasdan akusherlik kon’yugatasi kodiga almashtirilmaydi. Ona chiqish natijasi Core Encounter binding ida, qabul qiluvchi muassasa admission.destination da. Yo‘ldosh ajralish usuli Procedure.outcome emas.
- 096 mualliflari ko‘rsatilgan shifokor/akusher; ikkalasi yo‘q bo‘lsa ma’lum haqiqiy to‘ldirgan foydalanuvchi. Chiqarishni bajargan foydalanuvchi avtomatik muallif emas. Shaxs ma’lum, rol noma’lum bo‘lsa UZCorePractitioner mumkin; kasb o‘ylab topilmaydi. Provenance/attestatsiya 066 jarayonida; DHP agenti klinik muallifni almashtirmaydi. UZCoreProvenance hujjat nishoni Bundle bo‘lishi mumkin, Composition emas.
- Taqdim etilgan frontend tavsifida gospitalizatsiya tugagach tahrirlash bloklangan. Yangi tahrirlarni uzatish chiqarishdan keyingi UI tahrirlash tugmasini anglatmaydi. Saqlangan tahrirni chop etish yangi fakt yaratmaydi. Anamnez sonlari joriy tug‘ruqdan hisoblanmaydi.

### Composition bo‘limlari

Quyidagi 13 nomlangan kodli kesim ixtiyoriy (0..1). Epidemiologik anamnez manba matni bilan, qat’iy kodli diskriminatorsiz qo‘shimcha ochiq ixtiyoriy bo‘limdir. FHIR bo‘lim mazmuni invariantlari saqlanadi; mazmunsiz bo‘lim o‘rniga soxta yozuv yaratilmaydi.

| Kesim | Bo‘lim kodi | Ruxsat etilgan yozuvlar |
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

### Kod tizimlari va identifikatorlar

Kod, birlik tizimi va identifikator fazosi alohida. ValueSet URL Coding.system emas. Integrations CS/VS havolalari shu tarmoq ta’riflariga olib boradi; mavjudligi kelishish yoki joylashtirish isboti emas. Noaniq manba nomidan xalqaro kod taxmin qilinmaydi.

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

### Hujjat va bemor identifikatsiyasi

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Hujjat identifikatori | Идентификатор документа | `Composition.identifier; Bundle.identifier`<br/>DMED manbasi: `data.id; document revision context` | `urn:ietf:rfc:3986` | urn:uuid:… |
| Shakl raqami | Номер формы | `Composition.identifier` | `form-number` | 096 |
| Tibbiy karta raqami | Номер медкарты пациентки | `Patient.identifier[healthCardId]`<br/>DMED manbasi: `data.patient.number_med_card` | `HC` | MED-096-0001 |
| JShShIR | ПИНФЛ | `Patient.identifier[nationalId]` | `NI` | 14 digits, when available |
| Bemor F.I.Sh. | ФИО пациентки | `Patient.name.text; family; given`<br/>DMED manbasi: `data.patient.name` | `—` | Synthetic patient |
| Tug‘ilgan sana | Дата рождения | `Patient.birthDate` | `—` | 1990-04-12 |
| Millati | Национальность | `Patient.extension[nationality].extension[code].valueCodeableConcept`<br/>DMED manbasi: `data.nationality` | `Core nationality-cs` | source code |
| Yashash manzili | Адрес проживания | `Patient.address`<br/>DMED manbasi: `data.patient.place_residence` | `Core address-use rules` | source address |
| Ro‘yxatdan o‘tgan manzil | Адрес регистрации | `Patient.address`<br/>DMED manbasi: `data.patient.place_registration` | `Core address-use rules` | source address |
| Oilaviy holati | Семейное положение | `Patient.maritalStatus`<br/>DMED manbasi: `data.patient.family_status` | `v3-MaritalStatus#M` | married |
| Telefon | Телефон | `Patient.telecom` | `system = phone` | source telephone |
| Tibbiy muassasa STIRi | ИНН медицинской организации | `Organization.identifier[taxId]` | `Core soliq identifier` | 999999999 |
{: .mapping-fields}

### Ona gospitalizatsiyasi, chiqarish va o‘lim

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Kasallik tarixi raqami | Номер истории болезни | `Encounter.identifier`<br/>DMED manbasi: `data.hospitalization_id` | `medical-record-number` | 20676 |
| Qabul qilingan sana va vaqt | Дата и время поступления | `Encounter.actualPeriod.start`<br/>DMED manbasi: `data.hospitalization.start_at` | `—` | 2026-08-30T09:15:00+05:00 |
| Chiqarilgan sana va vaqt | Дата и время выписки | `Encounter.actualPeriod.end` | `—` | source date/time |
| Palata | Палата | `Encounter.location.location → Location.identifier[unit]`<br/>DMED manbasi: `data.hospitalization.chamber` | `location-kinds-cs#Ward` | 12 |
| Yo‘llagan muassasa | Направившая организация | `Encounter.admission.origin → Organization.name`<br/>DMED manbasi: `data.hospitalization.sending_clinic.title` | `—` | source organization |
| Chiqarildi | Выписана | `Encounter.admission.dischargeDisposition` | `Core home CS#mserv-0004-00004` | discharged |
| Boshqa muassasaga o‘tkazildi | Переведена | `Encounter.admission.dischargeDisposition` | `discharge-disposition#other-hcf` | transferred |
| Vafot etdi | Умерла | `Encounter.admission.dischargeDisposition` | `discharge-disposition#exp` | died |
| O‘tkazilgan muassasa | Учреждение перевода | `Encounter.admission.destination → Organization.identifier[taxId]`<br/>DMED manbasi: `data.pregnancy_birth.clinic.inn` | `Core soliq identifier` | 999999999 |
| O‘lim sanasi va vaqti | Дата и время смерти | `Patient.deceasedDateTime`<br/>DMED manbasi: `postmortem epicrisis; API selector pending` | `—` | source precision |
| O‘lim ma’lum, sana noma’lum | Смерть известна, дата неизвестна | `Patient.deceasedBoolean` | `—` | true |
| Ona o‘limining davri | Период смерти матери | `Observation.component.valueCodeableConcept`<br/>DMED manbasi: `data.pregnancy_birth.death_time` | `maternal-death-timing-vs; mapping pending` | omit until source meaning verified |
{: .mapping-fields}

### Tashxislar va operatsiyalar

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Qabul tashxisi | Поступной диагноз | `Condition.code; Encounter.diagnosis.condition`<br/>DMED manbasi: `data.admission_diagnosis.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00002` | O26.9 |
| Klinik tashxis | Клинический диагноз | `Condition.code; Encounter.diagnosis.use.text`<br/>DMED manbasi: `data.disease_codes[source=hospitalization, type=main].disease_code.code` | `ICD-10; source role text` | O14.1 |
| Yakuniy tashxis | Окончательный диагноз | `Condition.code; Condition.extension[diagnosisType]`<br/>DMED manbasi: `data.disease_codes[source=medical_case, type=main].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00003` | O80 |
| Asoratlar | Осложнения | `Condition.code; Condition.extension[diagnosisType]`<br/>DMED manbasi: `data.disease_codes[*].disease_code.code` | `ICD-10; diagnosis-type-cs#gencl-0001-00005` | source diagnosis |
| Hamroh kasalliklar | Сопутствующие заболевания | `Condition.code; Condition.extension[diagnosisType]` | `ICD-10; diagnosis-type-cs#gencl-0001-00004` | source diagnosis |
| Operatsiya | Операция | `Procedure.code; occurrence[x]; performer.actor`<br/>DMED manbasi: `data.surgical_interventions[*].ichi.title; performed_at` | `ICHI if supplied; otherwise code.text` | source operation title |
{: .mapping-fields}

### Anamnez, allergiya, qon guruhi va homiladorlik

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Oldingi kasalliklar va operatsiyalar | Перенесённые болезни и операции | `Condition; Procedure` | `verified source codes or source text` | source history |
| Akusherlik va epidemiologik anamnez | Акушерский и эпидемиологический анамнез | `QuestionnaireResponse.item.answer` | `form-096-history Questionnaire` | source answers |
| Turmush o‘rtog‘i haqida | Сведения о супруге | `RelatedPerson; clinical facts with the correct subject` | `verified relationship code` | source data |
| Allergiya | Аллергия | `AllergyIntolerance.code; reaction`<br/>DMED manbasi: `data.allergies[]` | `verified source code or text` | source allergy |
| Ma’lum allergiya yo‘q | Явно указано отсутствие известных аллергий | `AllergyIntolerance.code` | `SCT#716186003` | only an explicit negative history |
| Qon guruhi | Группа крови матери | `Observation.code → valueCodeableConcept`<br/>DMED manbasi: `data.patient_detail.blood_type` | `LOINC#883-9; abo-blood-group-vs` | A / II |
| Rezus omil | Резус-фактор матери | `Observation.code → valueCodeableConcept`<br/>DMED manbasi: `data.patient_detail.rh_factor` | `LOINC#10331-7; rh-factor-vs` | positive |
| Homiladorlikdagi ko‘riklar soni | Количество осмотров во время беременности | `Observation.code → valueInteger`<br/>DMED manbasi: `data.pregnancy_progress_count` | `LOINC#68493-6` | 6 |
| Homiladorliklar soni | Количество беременностей | `Observation.code → valueInteger`<br/>DMED manbasi: `data.birth_protocol.total_pregnancies` | `LOINC#11996-6` | 4 |
| Tug‘ruqlar soni | Количество родов / паритет | `Observation.code → valueInteger`<br/>DMED manbasi: `data.birth_protocol.total_births` | `LOINC#11977-6` | 2 |
| Oxirgi hayz sanasi | Дата последней менструации | `Observation.code → valueDateTime`<br/>DMED manbasi: `data.last_menstruation` | `LOINC#8665-2` | 2025-12-01 |
| Homilaning birinchi qimirlashi | Дата первого шевеления | `Observation.code → valueDateTime`<br/>DMED manbasi: `data.first_fetal_movement` | `LOINC#57065-5` | 2026-04-10 |
{: .mapping-fields}

### Ona o‘lchovlari va pelvimetriya

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Bo‘yi | Рост матери | `Observation.code → valueQuantity`<br/>DMED manbasi: `data.hospitalization.height` | `LOINC#8302-2; UCUM cm` | 168 cm |
| Vazni | Вес матери | `Observation.code → valueQuantity`<br/>DMED manbasi: `data.hospitalization.weight` | `LOINC#29463-7; UCUM kg` | 72.4 kg |
| Tana harorati | Температура | `Observation.code → valueQuantity`<br/>DMED manbasi: `data.hospitalization.temperature` | `LOINC#8310-5; UCUM Cel` | 36.8 Cel |
| D. spinarum | D. spinarum | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0001; UCUM cm` | 25 cm |
| D. cristarum | D. cristarum | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0002; UCUM cm` | 28 cm |
| D. trochanterica | D. trochanterica | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0003; UCUM cm` | 31 cm |
| C. externa | C. externa | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0004; UCUM cm` | 20 cm |
| C. diagonalis | C. diagonalis | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `SCT#249011002; UCUM cm` | 12.5 cm |
| C. vera | C. vera | `Observation.code → valueQuantity`<br/>DMED manbasi: `UI field; exact API selector pending` | `maternal-pelvimetry-measurement-code-cs#chr-0083-0006; UCUM cm` | 11 cm |
| Qorin aylanasi | Обхват живота | `Observation.code → valueQuantity`<br/>DMED manbasi: `data.abdominal_circumference` | `LOINC#8280-0; UCUM cm` | 98 cm |
| Bachadon tubi balandligi | Высота дна матки | `Observation.code → valueQuantity`<br/>DMED manbasi: `data.uterine_fundus_height` | `LOINC#11881-0; UCUM cm` | 32 cm |
{: .mapping-fields}

### Homilani baholash

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Homilaning yotishi | Положение плода | `Observation.component.code → valueCodeableConcept`<br/>DMED manbasi: `data.fetal_position` | `LOINC#11874-5; fetal-lie-vs` | longitudinal |
| Homilaning pozitsiyasi va turi | Позиция и вид плода | `Observation.component.code.text → valueCodeableConcept.text` | `exact source text; mapping pending` | source description |
| Homila yurak urishi | Сердцебиение плода | `Observation.component.code → valueQuantity or valueInteger`<br/>DMED manbasi: `data.fetal_heartbeat` | `LOINC#55283-6; UCUM /min for Quantity` | 145 /min |
| Yurak tovushlari eshitiladigan joy | Место выслушивания сердцебиения | `Observation.component.code.text → valueString` | `source text` | source location |
| Homilaning oldinda kelishi | Предлежание плода | `Observation.component.code → valueCodeableConcept`<br/>DMED manbasi: `data.fetal_presentation` | `LOINC#11877-8; fetal-presentation-vs` | cephalic |
| Homilaning taxminiy vazni | Предполагаемый вес плода | `Observation.component.code → valueQuantity`<br/>DMED manbasi: `data.estimated_fetal_weight` | `LOINC#11727-5; UCUM g` | 3100 g |
{: .mapping-fields}

### Tug‘ruq jarayoni va qog‘onoq suvlari

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Tug‘ruqning boshlanishi va tugashi | Начало и окончание родового процесса | `Observation.effectivePeriod`<br/>DMED manbasi: `source protocol timestamps` | `SCT#386216000` | actual known interval |
| Qog‘onoq pufagi yorilgan vaqt | Разрыв околоплодного пузыря | `Observation.component.code.text → valueDateTime` | `source label; no invented timestamp` | 2026-08-16T10:05:00+05:00 |
| Qog‘onoq suvlari | Характер околоплодных вод | `Observation.component.code → valueCodeableConcept` | `LOINC#1887-9; amniotic-fluid-characteristic-vs` | verified source value |
| I davr | I период | `Observation.component.code → valueQuantity` | `SCT#6893006; UCUM min` | 355 min |
| II davr | II период | `Observation.component.code → valueQuantity` | `SCT#42857002; UCUM min` | 25 min |
| III davr | III период | `Observation.component.code → valueQuantity` | `SCT#15898009; UCUM min` | 10 min |
| Umumiy davomiylik | Общая длительность | `Observation.component.code → valueQuantity` | `SCT#271562002; UCUM min` | 390 min |
{: .mapping-fields}

### Har bir chaqaloq haqidagi ma’lumotlar

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Har bir chaqaloq | Отдельный ребёнок | `Patient; Observation.subject`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*]` | `LOINC#57075-4 for delivery information` | one Patient per child |
| Chaqaloq tibbiy kartasi | HC ребёнка | `Patient.identifier[healthCardId]` | `HC` | distinct stable card number |
| Tug‘ilgan sana va vaqt | Дата и время рождения | `Patient.birthDate; birthTime extension; Observation.effectiveDateTime` | `Core birth-time rules` | source precision |
| Tirik tug‘ilish | Живорождение | `Observation.component.code → valueCodeableConcept`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#281050002` | live_birth |
| O‘lik tug‘ilish | Мертворождение | `Observation.component.code → valueCodeableConcept`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*].birth_outcome` | `LOINC#63893-2 → SCT#237364002` | stillbirth |
| Antenatal o‘lim | Антенатальная гибель | `Condition.code; subject = child` | `SCT#237361005` | only when period is known |
| Intranatal o‘lim | Интранатальная гибель | `Condition.code; subject = child` | `SCT#237362003` | only when period is known |
| Tug‘ilgandagi vazn | Вес при рождении | `Observation.component.code → valueQuantity`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*].weight_in_grams` | `LOINC#8339-4; UCUM g` | 3250 g |
| Tug‘ilgandagi bo‘yi | Рост при рождении | `Observation.component.code → valueQuantity` | `LOINC#89269-5; UCUM cm` | 49 cm |
| Bosh aylanasi | Окружность головы | `Observation.component.code → valueQuantity` | `LOINC#9843-4; UCUM cm` | 34 cm |
| Ko‘krak aylanasi | Окружность груди | `Observation.component.code → valueQuantity` | `SCT#248366000; UCUM cm` | 32 cm |
| Apgar bahosi, 1-daqiqa | Апгар на 1-й минуте | `Observation.component.code → valueInteger`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*].apgar_score` | `LOINC#9272-6` | 8 |
| Tug‘ilgandan keyingi o‘lim | Смерть после живорождения | `Patient.deceased[x]; documented clinical fact`<br/>DMED manbasi: `data.birth_protocol.newborn_children[*].postnatal_death` | `not Stillbirth` | source death date or true |
| Chaqaloqning chiqishi yoki o‘tkazilishi | Выписка или перевод ребёнка | `child Encounter.actualPeriod; admission.destination` | `child UZCoreEncounter` | source child event |
{: .mapping-fields}

### Joriy tug‘ruq sonlari va avvalgi homiladorliklar

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Hozirgi tug‘ruqda tirik tug‘ilganlar | Живорождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `LOINC#73773-4` | 2 |
| Hozirgi tug‘ruqda o‘lik tug‘ilganlar | Мертворождённые в текущих родах | `Observation.component.valueInteger (subject = mother)` | `SCT#252112002` | 0 |
| Oldingi homiladorliklar natijalari | Исходы предыдущих беременностей | `maternal Observation; source history` | `mapping pending` | omit if unavailable |
{: .mapping-fields}

### Yo‘ldosh va tug‘ruqdan keyingi kuzatuvlar

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Yo‘ldosh, pardalar va kindik | Послед, оболочки и пуповина | `Observation.component.value[x]` | `only reviewed indicator codes or source text` | source findings |
| Qon yo‘qotish | Кровопотеря | `Observation.component.code.text → valueQuantity` | `UCUM mL` | 320 mL |
| Yo‘ldosh ajralish usuli | Способ отделения последа | `Procedure.note.text` | `method is not Procedure.outcome` | source method |
| Tug‘ruqdan keyingi kuzatuv | Послеродовое наблюдение | `Observation.effectiveDateTime; component.value[x]` | `individual verified codes or source text` | one row per source assessment |
{: .mapping-fields}

### Tayinlovlar, davolash va hujjatlar

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Dori buyurilishi | Назначение лекарственного средства | `MedicationRequest.medication; dosageInstruction` | `verified medication code or source text` | source prescription |
| Dori yuborilishi | Введение лекарственного средства | `MedicationAdministration.medication; occurence[x]; dosage` | `verified medication code or source text` | source administration |
| Tekshiruv buyurilishi | Назначение исследования | `ServiceRequest.code; authoredOn` | `verified laboratory catalog` | source order |
| Tekshiruv natijasi | Результат исследования | `Observation.code; value[x]; effective[x]`<br/>DMED manbasi: `data.pregnancy_birth.analyses[*]` | `verified LOINC; UCUM when applicable` | source result |
| Muolaja natijasi | Результат вмешательства | `Procedure.outcome` | `SCT#385669000 / 385670004 / 385671000` | explicit source outcome |
| Ishlatilgan materiallar | Использованные материалы | `SupplyDelivery.suppliedItem` | `verified source catalog` | source item and quantity |
| Mehnatga layoqatsizlik varaqasi | Больничный лист | `SickLeaveCarePlan` | `existing SickLeaveCarePlan profile` | source certificate |
{: .mapping-fields}

### Mualliflar va ma’lumot kelib chiqishi

| UZ | RU | FHIR Path / DMED manbasi | Code | Misol |
|---|---|---|---|---|
| Davolovchi shifokor | Лечащий врач госпитализации | `Encounter.participant.individual` | `PractitionerRole / Practitioner as permitted` | identified source clinician |
| Shakldagi shifokor va akusher | Врач и акушер в форме | `Composition.author; clinical performer references` | `UZCorePractitionerRole or UZCorePractitioner` | known source identity |
| Shaklni to‘ldirgan foydalanuvchi | Заполнивший форму пользователь | `Composition.author when both selected clinicians absent` | `identified source author` | not automatically the discharging user |
| Mas’ul muassasa | Организация документа | `Composition.custodian` | `UZCoreOrganization` | optional source organization |
| Saqlash vaqti va kelib chiqishi | Время сохранения и происхождение | `Composition.date; Provenance.recorded; agent` | `Form 066 workflow` | source revision timestamp |
{: .mapping-fields}

### Manba tasdig‘ini kutayotgan mosliklar

- Tahlil katalogi: WR I/II, OIV 1/2/tezkor, umumiy qon tahlili, HBsAg I/II, gonokokk, toksoplazmoz, siydik, surtma va najas uchun ID, ta’rif, usul/material va natija turlari kerak. Umumiy UI nomidan alohida analit yoki usulga xos LOINC tanlanmaydi. Kodlash kelishilguncha erkin natija matn sifatida saqlanadi.
- Homilaning oldinda kelishi: UI da 13 variant; amaldagi ValueSet loyihasi to‘liq manba moslik jadvali emas. To‘liq/noto‘liq/aralash kabi nomlarga ta’rif kerak. Homilaning yotishi, oldinda kelishi va yurak tovushi eshitiladigan joy alohida faktlar.
- Tashxis rollari va operatsiyalar: manba lug‘atlari va haqiqiy ICHI maydoni yoki ichki ID bog‘lanishi kerak. Nom mashina kodi emas. Maqsadli rollar Core diagnosis-type kengaytmasida; misoldagi eski Condition.category rollari DMED ning yakuniy jadvali emas. Klinik tashxis avtomatik working yoki confirmed emas.
- Ona o‘limining davri toifa, sana/vaqt emas. UI nomlari almashgani haqidagi xabar mustaqil tekshirilmagan: tanlangan nom → API qiymati → kutilgan ma’no kerak. Ma’nosi noma’lum davr uzatilmaydi; o‘lim sanasi undan mustaqil.
- Anamnezdagi tirik, o‘lik tug‘ilgan va vafot etgan bolalar soni joriy tug‘ruqdan olinmaydi. Joriy sonlar aniq kontekst talab qiladi; keyingi o‘limlar uchun kuzatuv davri kerak. Har bola, jumladan o‘lik tug‘ilgan bola uchun HC berilishi, noyobligi va barqarorligi tasdiqlansin. Nusxaning qabul qilinishi qidiriladigan master-Patient yaratilganini isbotlamaydi.
- Olti tos o‘lchovi, ayrim muallif maydonlari va aniq o‘lim/hodisa vaqtlari uchun API selektorlari tasdiqlanishi kerak. UI maydoni yoki sun’iy Bundle muayyan JSON selektorini isbotlamaydi. Xom qiymatlar moslashtirilishidan oldin noaniq Rh nomi va takrorlanuvchi homila yurak urishi maydonlari aniqlashtirilsin.

### Bundle tuzilmasi va misollar

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

- [To‘liq sun’iy hujjat](Bundle-example-form-096-maternity-medical-record.html)
- [Antenatal o‘lik tug‘ilish](Bundle-example-form-096-antepartum-stillbirth.html)
- [Intranatal o‘lik tug‘ilish](Bundle-example-form-096-intrapartum-stillbirth.html)
- [Minimal klinik hujjat](Bundle-example-form-096-minimal.html)
- [Roli noma’lum muallif](Bundle-example-form-096-author-without-role.html)
