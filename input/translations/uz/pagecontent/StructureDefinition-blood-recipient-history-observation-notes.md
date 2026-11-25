> **Mashina tarjimasi, inson tomonidan tekshirilishi zarur.** Ushbu sahifa ingliz tilidan sun'iy intellekt yordamida avtomatik tarjima qilingan va hali muharrir tomonidan tekshirilmagan. Har qanday nomuvofiqlikda asl inglizcha versiya ustuvor hisoblanadi.

### Tezkor boshlash {#quick-start}

Ushbu profil uchun keng tarqalgan API o'zaro ta'sirlari. Profil Observation asosida qurilgan, shuning uchun Observation endpointidan foydalaning. So'rovlar JWT kirish tokenini talab qiladi - qarang: [Xavfsizlik va autentifikatsiya](https://dhp.uz/fhir/core/uz/api-access.html#security). `[base]` bu [FHIR server bazaviy URL manzili](https://dhp.uz/fhir/core/uz/api-access.html#endpoints); `|` tizimni uning qiymatidan ajratadi va URL'da `%7C` sifatida kodlanishi shart.

**Server id bo'yicha o'qish**

```
GET [base]/Observation/[id]
```

**Retsipiyentning transfuzion yoki akusherlik anamnezini qidirish**

```
GET [base]/Observation?patient=Patient/[id]&code=https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs%7Cbldcomp-0001-00003
GET [base]/Observation?patient=Patient/[id]&code=https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs%7Cbldcomp-0001-00004
```

**Yaratish**

```
POST [base]/Observation
{
  "resourceType": "Observation",
  "meta": {
    "profile": [ "https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation" ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "https://terminology.dhp.uz/fhir/integrations/CodeSystem/blood-transfusion-assessment-cs",
        "code": "bldcomp-0001-00003"
      }
    ]
  },
  "subject": { "reference": "Patient/[id]" },
  "effectiveDateTime": "2026-11-11T10:10:00+05:00",
  ...
}
```

**Xatoni tuzatish** - to'liq resursni tuzatilgan qiymat va `status` = `amended` bilan PUT orqali qayta yuboring:

```
PUT [base]/Observation/[id]
If-Match: W/"3"   # the ETag from your last read; 412 if it changed since
```

Qo'llab-quvvatlanadigan qidiruv parametrlarining to'liq ro'yxati uchun [CapabilityStatement](https://dhp.uz/fhir/core/uz/CapabilityStatement-DHPCapabilityStatement.html#Observation1-9) ga qarang.

### Aloqador materiallar

- [Blood Service](blood-service.html) &middot; [Qon xizmati shakllari](forms-volume-08-blood-service.html)
- [UZ Core Observation](https://dhp.uz/fhir/core/uz/StructureDefinition-uz-core-observation.html)
- [Must Support](https://dhp.uz/fhir/core/uz/must-support.html) &middot; [Umumiy ko'rsatmalar](https://dhp.uz/fhir/core/uz/general-guidance.html)
