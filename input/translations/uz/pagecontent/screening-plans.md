# Skrining rejalari va takliflari

Bemor rejasi mavjud [UZ Core ServiceRequest](https://dhp.uz/fhir/core/StructureDefinition-uz-core-servicerequest.html) dan foydalanadi: `intent = plan`, SNOMED CT `310422005` toifasi va `https://dhp.uz/fhir/core/sid/prg/uz/program` tizimidan aynan bitta dastur identifikatori. Klinik [ScreeningServiceRequest](StructureDefinition-screening-service-request.html) MIS manba kontraktini saqlaydi.

Vazirlik taklifi [UZ Core PlanDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-plan-definition.html) ga aynan bitta `instantiatesCanonical = canonical|version` havolasini yuboradi; mustaqil MIS rejasi bu maydonni yubormaydi. Kelib chiqish reja intent, toifa va dastur bo‘yicha tanilgandan so‘ng aniqlanadi, URL shakli bo‘yicha emas. Har ikkala tur UZ Core ServiceRequest dan foydalanadi, `meta.source` va `occurrencePeriod` ni yubormaydi. Ilova kontrakti bemorga `subject`, `authoredOn` va kamida bitta `performer` ni talab qiladi. Ixtiyoriy klinik kod `code.concept` da yuboriladi, `code.reference` da emas. Klinik natijalardagi manba saqlanadi. 365 kunlik eslatma reja davri emas.

`code` ixtiyoriy; yuborilsa klinik kod `code.concept` da bo'ladi. Dastur identifikator bo'yicha topiladi. `performer` xizmatni bajaruvchini ko'rsatadi; dasturdan DMED yoki OPV tizimiga yo'naltirish kim rejani yaratganidan mustaqil.

## Dasturlar va ta'riflar

[Dastur turlari ValueSet](https://dhp.uz/fhir/core/ValueSet-screening-program-type-vs.html) sakkizta SNOMED CT skrining kodi va saqlangan `screening-code-cs` kodlarini, jumladan patronajni o'z ichiga oladi. `$expand` da tarjimalar so'raladi: SNOMED uchun `screening-sct-cs`, mahalliy kodlar uchun `screening-code-cs`. Identifikator qiymati kod bo'ladi, tizimi esa klinik CodeSystem URL emas, `prg` bo'lib qoladi.

| Dastur | Identifikator qiymati | Tizim |
|---|---|---|
| Yurak ishemik kasalligi | `171223006` | DMED |
| Fertillik | `408961002` | DMED |
| Serebrovaskulyar skrining | `mserv-0007-00003` | DMED |
| Gelmintozlar | `171147008` | DMED |
| Yurak-qon tomir xavfi | `300007000` | DMED |
| Diabet | `171183004` | DMED |
| Ko'krak bezi so'rovnomasi | `mserv-0007-00007` | DMED |
| Onkogematologiya | `762445000` | DMED |
| Bachadon bo'yni so'rovnomasi | `mserv-0007-00009` | DMED |
| Ko'krak bezi dasturi | `268547008` | OPV |
| Bachadon bo'yni dasturi | `171149006` | OPV |

DMED ko'krak bezi va bachadon bo'yni so'rovnomalarining klinik kodlari SNOMED CT bo'lib qoladi; **dastur identifikatorlari** alohida mahalliy kodlar. Klinik kod yoki tarjima qilingan nomning bir xilligi dasturlarni birlashtirmaydi. `breast-cervical-unspecified` natijalar tasnifi bo'lib qoladi, yangi rejada qo'llanmaydi.

Skrining ta’riflari mavjud [UZ Core PlanDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-plan-definition.html) va [UZ Core ActivityDefinition](https://dhp.uz/fhir/core/StructureDefinition-uz-core-activitydefinition.html) dan foydalanadi. Ilova kanonik URL, o‘zgarmas versiya va bemor rejasidagi ayni dastur identifikatorini talab qiladi. PlanDefinition.useContext[screeningFocus] va ActivityDefinition.useContext da SNOMED CT `360156006` qo‘llanadi. Dastur identifikatori barqaror yozuv identifikatoriga qo‘shimcha; Questionnaire.useContext dagi program integratsiya sohasi uchun alohida tasnifdir.

`PlanDefinition.action.definitionCanonical` taklif ActivityDefinition kanonik URL va versiyasini belgilaydi. [Taklif shabloni misoli](ActivityDefinition-example-hpv-cervical-invitation-activity.html) `kind = ServiceRequest`, `intent = plan`, `profile = UZCoreServiceRequest` dan foydalanadi. Ilova bemor/dastur va amaldagi ta’rif uchun bitta taklif yaratib, bemor, toifa, identifikatorlar va aniq PlanDefinition havolasini to‘ldiradi. Questionnaire/Observation bu shablonda yakunlash talablari emas; MIS mavjud klinik kontraktidan foydalanadi. DHP natijalardan yakunlashni hisoblamaydi. Skrining qoidalarini ilova tekshiradi; faqat Core bo‘yicha validatsiya to‘liq kontraktni tasdiqlamaydi. Yangi profillar kiritilmaydi.

## Qidirish va qayta foydalanish

```http
GET [base]/ServiceRequest?subject=Patient/{id}&intent=plan&status=draft,active&category=http://snomed.info/sct|310422005&identifier=https://dhp.uz/fhir/core/sid/prg/uz/program|{kod}
```

Haqiqiy so'rovdagi parametr qiymatlarini URL-kodlang. Rejani `20135006`, faqat code yoki eski URL prefiksi orqali tanimang. `20135006` Core da klinik skrining/patronaj xizmatlari uchun saqlanadi, taklif uchun emas.

Vazirlik taklifi qayta ishlatilishidan oldin uning aniq `canonical|version` qiymatini amaldagi dastur bilan solishtiring. Eski versiyadagi ochiq taklif yangisini to'smaydi. Nol mos reja — yaratish mumkin; bitta — qayta foydalanish; bir nechtasi — birinchisini olish emas, konflikt. Serverning `instantiates-canonical` qidirishini tekshiring. Atomik yaratish/unikallik mezonlariga joriy versiyani kiriting; barcha ochiq rejalar bo'yicha shartli yaratish eski versiyani noto'g'ri tanlashi mumkin.

GET dan keyin shartsiz POST unikallikni kafolatlamaydi. To'liq kelishilgan identifikatsiya bilan shartli yaratish yoki server unikalligi va holat o'zgarishida `If-Match` kerak. Mavjud taklifning identifikatorlari va kelib chiqish belgilarini saqlang.

## Takroriy tekshiruvlar va holatlar

OPV rejasi dastur ta'rifi va kohortga tegishlilik amal qilgan vaqt davomida takroriy tekshiruvlar uchun qayta ishlatiladi. Navbatdagi tekshiruv vaqti o'zi yangi taklif yaratmaydi. Har bajarilish yangi klinik buyurtma va natijalar bilan qayd etiladi; ular shu reja va bevosita buyurtmaga bog'lanadi. Sana va buyurtma havolalari bajarilishlarni ajratadi; bu yerda yangi sikl identifikatori kiritilmaydi.

Holatni MIS o'zgartiradi. OPV taklifni active qiladi va alohida tekshiruvdan keyin completed qilmaydi. DMED bog'langan QuestionnaireResponse ni saqlagandan so'ng o'z rejasini completed qiladi. Keyingi DMED so'rovnomasi uchun yangi reja yaratish qoidasi taqdim etilgan kontraktda belgilanmagan; avtomatik takrorlashdan oldin kelishish kerak. Boshqa dastur rejasini yopmang.

Kohortdan chiqish yoki PlanDefinition almashtirilishi eski rejaning amal qilishini tugatadi. **Kelishilmagan taklif:** kohortdan chiqish → completed; chiqarish yoki ta'rifni almashtirish → revoked. Yangi reja eskisiga `ServiceRequest.replaces` bilan bog'lanadi; tarixiy `basedOn` o'zgarmaydi. Ixtiyoriy standart `request-statusReason` kengaytmasi qo'llansa, kod [sabablar ValueSet](ValueSet-screening-plan-closure-reason-vs.html) dan olinishi mumkin. Sabab va holat mosligi majburiy qoida emas.

FHIR da completed barcha ko'zda tutilgan ishlar bajarilganini anglatadi. Bajarilmagan ish bilan kohortdan chiqishda uning ma'nosini alohida kelishish va revoked ni ko'rib chiqish kerak. Rozilik, rad etish va chiqarish boshqa-boshqa qarorlar; Consent yo'qligi rad etish emas.

## Natijalar, moslik va reliz

Composition ixtiyoriy moslik resursi bo‘lib qoladi: OPV uni saqlangan profil bo‘yicha yuborishda davom etishi mumkin. retired holati valid tarixiy payload ni taqiqlamaydi. Yangi jarayon Composition ni talab qilmaydi va reja yakunlanishini undan aniqlamaydi. Natijalar aniq dastur identifikatori yoki rejaga basedOn bo'yicha olinadi. [ScreeningComposition](StructureDefinition-screening-composition.html) retired bo'ladi, lekin tarixiy hujjatlarni tekshirish uchun saqlanadi; avvalgi misollar tarixiydir. Server yozuvlari bu manba o'zgarishi bilan o'chirilmaydi yoki ko'chirilmaydi.

Reja havolasi bilan birga bevosita buyurtma havolasini saqlang. Core Observation basedOn 0..*, patomorfologiya ServiceRequest 1..*, immunogistokimyo Observation bir nechta havolani qo'llaydi. Bunday payload ni mos Core serverga joylashtirilgandan keyin yuboring.

Eski `https://dhp.uz/fhir/core/sid/uz/screening-program-type` yangi yozuvlar uchun ishlatilmaydi. Tarix alohida migratsion moslik yo'li bilan o'qiladi; yangi rejani tanishda legacy belgilar va aliaslar qo'llanmaydi. NamingSystem kanonik URL saqlanadi. Klinik yo'llanma profili va meta.source saqlanadi. Ta’riflar mavjud Core profillaridan foydalanadi; focus va qo‘shimcha reja qoidalarini ilova tekshiradi.

Vazirlik yosh chegaralari, baholash sanasi, qo'shish/chiqarish qoidalari, rozilik maqsadi va huquqiy asosi, rad etish muddati va qamrovi, yopish va vorislikni tasdiqlaydi. Umumiy Group va ma'lumot almashish Consent avtomatik skrining kontrakti emas. Bemor uchun natija ko'rinishi alohida mahsulot qarori.

Core 0.11.0 ActivityDefinition.kind ValueSet da ServiceRequest siz nashr qilingan. Avval yangilangan Core 0.11.1 nashr qilinib ro‘yxatdan o‘tadi; keyin taklif shabloni, dastur reestri, alohida DMED dasturlari va kardinallik tuzatishlari bilan Integrations chiqariladi. Ilovalar ikkala paketni fhir.lock da ulaydi. Manba tayyorlash va mahalliy tekshirish reliz yoki serverga joylashtirish degani emas.

Emlash kalendarlari `PlanDefinition?context-type-value=focus$http://snomed.info/sct|33879002` orqali topiladi; focus yo'qligi emlash degani emas. Hududlar uchun `states-cs` ishlatiladi.

Manbalar: 09.10.2026 audit javobi, [FHIR R5 ServiceRequest](https://hl7.org/fhir/R5/servicerequest.html), [request-statusReason](https://hl7.org/fhir/extensions/StructureDefinition-request-statusReason.html).
