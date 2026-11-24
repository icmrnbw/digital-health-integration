> **Mashina tarjimasi, inson tomonidan tekshirilishi zarur.** Ushbu sahifa ingliz tilidan sun'iy intellekt yordamida avtomatik tarjima qilingan va hali muharrir tomonidan tekshirilmagan. Har qanday nomuvofiqlikda asl inglizcha versiya ustuvor hisoblanadi.

### Tezkor boshlash {#quick-start}

Ushbu profil uchun keng tarqalgan API o'zaro ta'sirlari. Profil Observation asosida qurilgan, shuning uchun Observation endpointidan foydalaning. So'rovlar JWT kirish tokenini talab qiladi - qarang: [Xavfsizlik va autentifikatsiya](https://dhp.uz/fhir/core/uz/api-access.html#security). `[base]` bu [FHIR server bazaviy URL manzili](https://dhp.uz/fhir/core/uz/api-access.html#endpoints); `|` tizimni uning qiymatidan ajratadi va URL'da `%7C` sifatida kodlanishi shart.

**Server id bo'yicha o'qish**

```
GET [base]/Observation/[id]
```

**Qon quyishdan oldingi baholashlarni qidirish** (retsipiyent, qon birligi, Encounter, mos kelmaslik natijasi bo'yicha)

```
GET [base]/Observation?patient=Patient/[id]&code=http://snomed.info/sct%7C252314007
GET [base]/Observation?focus=BiologicallyDerivedProduct/[id]
GET [base]/Observation?encounter=Encounter/[id]&code=http://snomed.info/sct%7C252314007
GET [base]/Observation?code=http://snomed.info/sct%7C252314007&component-value-concept=http://snomed.info/sct%7C250406009
```

**Yaratish**

```
POST [base]/Observation
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-transfusion-assessment-observation" ]
  },
  "status": "final",
  "code": { "coding": [ { "system": "http://snomed.info/sct", "code": "252314007" } ] },
  "subject": { "reference": "Patient/[id]" },
  "focus": [ { "reference": "BiologicallyDerivedProduct/[id]" } ],
  "effectiveDateTime": "2026-11-11T10:30:00+05:00",
  ...
}
```

**Xatoni tuzatish** - to'liq resursni tuzatilgan qiymat va `status` = `amended` bilan PUT orqali qayta yuboring, asl `effectiveDateTime` ni saqlang:

```
PUT [base]/Observation/[id]
If-Match: W/"3"   # the ETag from your last read; 412 if it changed since
```

Qo'llab-quvvatlanadigan qidiruv parametrlarining to'liq ro'yxati uchun [CapabilityStatement](https://dhp.uz/fhir/core/uz/CapabilityStatement-DHPCapabilityStatement.html#Observation1-9) ga qarang.

### Aloqador materiallar

- [Blood Service](blood-service.html) &middot; [Qon xizmati shakllari](forms-volume-08-blood-service.html)
- [UZ Core Observation](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-observation.html) &middot; [UZ Core BiologicallyDerivedProduct](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-biologically-derived-product.html)
- [Must Support](https://dhp.uz/fhir/core/uz/must-support.html) &middot; [Umumiy ko'rsatmalar](https://dhp.uz/fhir/core/uz/general-guidance.html)
