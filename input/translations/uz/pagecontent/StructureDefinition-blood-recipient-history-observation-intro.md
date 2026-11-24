> **Mashina tarjimasi, inson tomonidan tekshirilishi zarur.** Ushbu sahifa ingliz tilidan sun'iy intellekt yordamida avtomatik tarjima qilingan va hali muharrir tomonidan tekshirilmagan. Har qanday nomuvofiqlikda asl inglizcha versiya ustuvor hisoblanadi.

Blood Recipient History Observation qon quyishdan oldin retsipiyentdan olingan anamnezning bir qismini qayd etadi: transfuzion yoki akusherlik anamnezi. `code` qaysi biri ekanini ko'rsatadi, qiymat esa mos ValueSet'dan olinadi. Qon birligi uchun [Blood Transfusion Assessment Observation](StructureDefinition-blood-transfusion-assessment-observation.html) foydalanilgan anamnezni `derivedFrom` da sanab o'tadi. Profil [UZ Core Observation](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-observation.html) asosida qurilgan, shuning uchun o'qish va qidirish uchun Observation endpointidan foydalaning. Subyekt - retsipiyent, [UZ Core Patient](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-patient.html). Profil qon xizmatida, donorni ro'yxatga olishdan transfuziyagacha, UZ Core profillari bilan qanday birlashishi [Blood Service](blood-service.html) sahifasida tasvirlangan.

### Majburiy va Must Support ma'lumot elementlari

Quyidagi elementlar har doim mavjud bo'lishi (majburiy) yoki ma'lumot mavjud bo'lganda qo'llab-quvvatlanishi kerak ([Must Support](https://dhp.uz/fhir/core/uz/must-support.html)) - hammasi ham talab qilinmaydi, lekin sizning tizimingiz ma'lumotga ega bo'lganda har bir Must Support elementini to'ldirishi va qabul qilishda uni qayta ishlashi kerak. Bu inson o'qiy oladigan qisqacha bayon; quyidagi [rasmiy ko'rinishlar](#profile) aniq kardinalliklar, turlar va terminologiya bog'lanishlarini beradi.

#### Har bir Blood Recipient History Observation quyidagilarga ega bo'lishi shart

Har bir Blood Recipient History Observation status, code - *transfuzion anamnez* yoki *akusherlik anamnezi* - va subject - retsipiyent [Patient](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-patient.html) (1..1) ni olib yurishi kerak. Unda komponentlar yo'q.

#### Har bir Blood Recipient History Observation quyidagilarni qo'llab-quvvatlashi shart

- kodga mos ValueSet'dan anamnez toifasi (`valueCodeableConcept`);
- qiymat yo'qligining sababi (`dataAbsentReason`);
- Encounter va ijrochi - anamnezni yig'gan tibbiyot xodimi;
- anamnez yig'ilgan vaqt (`effective[x]`);
- UZ Core Observation'dan meros qolgan boshqa Must Support elementlari.

| `code` | `valueCodeableConcept` manbasi |
|---|---|
| `bldcomp-0001-00003` (transfuzion anamnez) | [Transfuzion anamnez toifasi](ValueSet-blood-transfusion-history-vs.html) |
| `bldcomp-0001-00004` (akusherlik anamnezi) | [Retsipiyentning akusherlik anamnezi toifasi](ValueSet-blood-recipient-obstetric-history-vs.html) |

Anamnez taalluqli bo'lmasa, masalan erkakda akusherlik anamnezi, qiymat o'rniga `dataAbsentReason` `not-applicable` yuboring. Uni aniqlab bo'lmasa, `unknown` yuboring.

### JSON'ni bosqichma-bosqich qurish

Quyidagi misollar transfuzion anamnezni va taalluqli bo'lmagan akusherlik anamnezini ko'rsatadi. Birini nusxalab moslashtiring - ko'rsatilgan har bir qiymat ushbu profil bo'yicha validatsiyadan o'tadi. To'liq namunaviy nusxalar: [transfuzion anamnez](Observation-example-blood-recipient-transfusion-history.html) va [akusherlik anamnezi](Observation-example-blood-recipient-obstetric-history.html).

#### Transfuzion anamnez

Kodlar [qon quyishdan oldingi baholash kodlari](CodeSystem-blood-transfusion-assessment-cs.html) va [transfuzion anamnez toifalari](CodeSystem-blood-transfusion-history-cs.html)dan olinadi:

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00003",
        "display": "Transfuzion anamnez"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "valueCodeableConcept": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-history-cs",
        "code": "bldcomp-0003-00001",
        "display": "Avval qon quyilmagan"
      }
    ]
  }
}
```

#### Taalluqli bo'lmagan akusherlik anamnezi

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00004",
        "display": "Akusherlik anamnezi"
      }
    ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  "dataAbsentReason": {
    "coding": [ { "system": "http://terminology.hl7.org/CodeSystem/data-absent-reason", "code": "not-applicable" } ]
  }
}
```

API chaqiruvlari misollari uchun ushbu sahifaning pastki qismidagi [Tezkor boshlash](#quick-start) bo'limiga qarang.
