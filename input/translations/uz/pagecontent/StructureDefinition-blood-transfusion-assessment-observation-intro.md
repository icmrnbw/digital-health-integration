> **Mashina tarjimasi, inson tomonidan tekshirilishi zarur.** Ushbu sahifa ingliz tilidan sun'iy intellekt yordamida avtomatik tarjima qilingan va hali muharrir tomonidan tekshirilmagan. Har qanday nomuvofiqlikda asl inglizcha versiya ustuvor hisoblanadi.

Blood Transfusion Assessment Observation retsipiyent va bitta qon birligi o'rtasidagi moslik sinovlarini qayd etadi: ABO bo'yicha moslik, Rh-Hr bo'yicha moslik va qon quyish boshida o'tkaziladigan biologik sinama, har biri o'z komponentida. Har bir birlik uchun bitta Observation yozing va birlik ma'lum bo'lsa, `focus` da uning [BiologicallyDerivedProduct](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-biologically-derived-product.html)ini ko'rsating. Retsipiyentdan olingan anamnez [Blood Recipient History Observation](StructureDefinition-blood-recipient-history-observation.html)da, dastlabki ABO qon guruhi esa LOINC `883-9` kodi bilan [UZ Core Observation](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-observation.html)da yoziladi; baholash ularni `derivedFrom` da sanab o'tadi. Profil [UZ Core Observation](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-observation.html) asosida qurilgan, shuning uchun o'qish va qidirish uchun Observation endpointidan foydalaning. Subyekt - retsipiyent, [UZ Core Patient](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-patient.html); yozuv qon quyish [Encounter](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-encounter.html)iga va sinovlarni o'tkazgan tibbiyot xodimiga havola qilishi mumkin. Profil qon xizmatida, donorni ro'yxatga olishdan transfuziyagacha, UZ Core profillari bilan qanday birlashishi [Blood Service](blood-service.html) sahifasida tasvirlangan.

### Majburiy va Must Support ma'lumot elementlari

Quyidagi elementlar har doim mavjud bo'lishi (majburiy) yoki ma'lumot mavjud bo'lganda qo'llab-quvvatlanishi kerak ([Must Support](https://dhp.uz/fhir/core/uz/must-support.html)) - hammasi ham talab qilinmaydi, lekin sizning tizimingiz ma'lumotga ega bo'lganda har bir Must Support elementini to'ldirishi va qabul qilishda uni qayta ishlashi kerak. Bu inson o'qiy oladigan qisqacha bayon; quyidagi [rasmiy ko'rinishlar](#profile) aniq kardinalliklar, turlar va terminologiya bog'lanishlarini beradi.

#### Har bir Blood Transfusion Assessment Observation quyidagilarga ega bo'lishi shart

Har bir Blood Transfusion Assessment Observation status, code - har doim SNOMED CT `252314007` *Blood transfusion test* - va subject - retsipiyent [Patient](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-patient.html) (1..1) ni olib yurishi kerak. Unda `value` yo'q: sinov natijalari komponentlarda yoziladi.

#### Har bir Blood Transfusion Assessment Observation quyidagilarni qo'llab-quvvatlashi shart

- baholashning biznes identifikatori;
- sinovdan o'tkazilgan qon birligi (`focus`);
- qon quyish Encounter'i va ijrochi - sinovlar uchun mas'ul tibbiyot xodimi, uning roli yoki tashkilot;
- sinovlar o'tkazilgan vaqt (`effective[x]`) va natija berilgan vaqt (`issued`);
- ABO va Rh-Hr bo'yicha moslik natijalari, har biri o'z komponentida;
- biologik sinama natijasi o'z komponentida;
- UZ Core Observation'dan meros qolgan boshqa Must Support elementlari, jumladan `derivedFrom`.

### JSON'ni bosqichma-bosqich qurish

Quyidagi misollar server qabul qiladigan eng kichik nusxadan to'liq baholashgacha boradi. Birini nusxalab moslashtiring - ko'rsatilgan har bir qiymat ushbu profil bo'yicha validatsiyadan o'tadi. To'liq namunaviy nusxa: [eritrotsitlar birligini baholash](Observation-example-blood-transfusion-assessment.html).

#### Yuborish kerak bo'lgan eng kichik kuzatuv

Uchta element majburiy: `status`, bu qon quyish sinovi ekanini ko'rsatuvchi `code` va `subject` (retsipiyent [Patient](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-patient.html)). Sinovlarning `effectiveDateTime` ini ham qo'shing: vaqtsiz natijani qon quyish bilan bog'lab bo'lmaydi.

```json
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "effectiveDateTime": "2026-11-11T10:30:00+05:00"
}
```

`subject` oddiy `Reference`, shuning uchun nishon to'g'ridan-to'g'ri `reference` ichida turadi.

#### To'liq baholash

Har bir sinov o'zining `component` slaysida yoziladi. Har bir slays ixtiyoriy va ko'pi bilan bir marta uchraydi; `code` slaysni tanlaydi, `valueCodeableConcept` esa shu slaysning ValueSet'idan bo'lishi shart:

| Slays | `code` | `valueCodeableConcept` manbasi |
|---|---|---|
| `aboCompatibility` | `bldcomp-0001-00001` | [Qon moslik natijasi](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `rhHrCompatibility` | `bldcomp-0001-00002` | [Qon moslik natijasi](ValueSet-blood-compatibility-result-vs.html) (SNOMED CT) |
| `biologicalTest` | `bldcomp-0001-00006` | [Musbat / manfiy natija](ValueSet-positive-negative-result-vs.html) (SNOMED CT) |

Komponent kodlari [qon quyishdan oldingi baholash kodlari](CodeSystem-blood-transfusion-assessment-cs.html)dan olinadi:

```json
{
  "resourceType": "Observation",
  "language": "uz",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [ { "system": "http://snomed.info/sct", "code": "252314007", "display": "Blood transfusion test" } ]
  },
  "subject": { "reference": "Patient/example-patient-john" },
  "encounter": { "reference": "Encounter/example-transfusion-assessment-encounter" },
  "focus": [ { "reference": "BiologicallyDerivedProduct/example-blood-component-product" } ],
  "effectiveDateTime": "2026-11-11T10:30:00+05:00",
  "issued": "2026-11-11T10:35:00+05:00",
  "performer": [ { "reference": "Practitioner/example-transfusion-assessment-practitioner" } ],
  "derivedFrom": [
    { "reference": "Observation/example-blood-recipient-transfusion-history" },
    { "reference": "Observation/example-blood-recipient-blood-group" }
  ],
  "component": [
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00001",
            "display": "ABO bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00002",
            "display": "Rh-Hr bo‘yicha moslik"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "250405008", "display": "Blood compatible" } ]
      }
    },
    {
      "code": {
        "coding": [
          {
            "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
            "code": "bldcomp-0001-00006",
            "display": "Biologik sinama"
          }
        ]
      },
      "valueCodeableConcept": {
        "coding": [ { "system": "http://snomed.info/sct", "code": "260385009", "display": "Negative" } ]
      }
    }
  ]
}
```

API chaqiruvlari misollari uchun ushbu sahifaning pastki qismidagi [Tezkor boshlash](#quick-start) bo'limiga qarang.
