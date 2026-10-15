Sakkizta majburiy bo'limning kardinalligi `1..1` bo'lib qoladi.
`medicalAndObstetricHistory`, `currentPregnancy`, `obstetricExamination`,
`laborCourse`, `newbornDeliveryRecord` va `postpartumPeriod` klinik bo'limlarida
yozuvlar bo'lmasligi mumkin (`entry 0..*`). Bunday holda `section.emptyReason`
hamda `section.text` dagi izoh majburiy (`form096-empty-section` invarianti).
Bo'lim sarlavhasi va kodi majburiyligicha qoladi.

Izoh bo'limning mazkur holatga tegishli emasligini (masalan, gospitalizatsiya
tug'ruqsiz yakunlanganini) manba tizimida ma'lumot yo'qligidan (masalan, DMED da
tug'ruqdan keyingi kuzatuvlar hali qayd etilmaganidan) ajratishi kerak. Ma'lumot
yo'qligi tekshiruv natijasi me'yorda ekanini yoki asoratlar yo'qligi
tasdiqlanganini anglatmaydi. Kardinallik talabini bajarish uchun soxta klinik
resurslar yaratish mumkin emas.

Yozuvlari bor bo'lim bir vaqtning o'zida `emptyReason` ni saqlay olmaydi — bu
FHIR ning meros olingan `cmp-2` qoidasi bilan taqiqlanadi. Bo'sh bo'lim `cmp-1`
qoidasini bajarishi uchun matnni ham saqlashi kerak; faqat `emptyReason` yetarli emas.

`admissionInformation` va `responsiblePersons` bo'limlarida kamida bitta yozuv
talab qilinadi. `Composition.author` majburiyligicha qoladi, `Composition.status`
esa `final` sifatida belgilangan. Ushbu tuzilmaviy qoidalar manba tizimidagi
shaklning rasmiy almashuvga tayyorligini tekshirish o'rnini bosmaydi.
