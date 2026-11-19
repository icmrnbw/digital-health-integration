Instance: donor-questionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Donor Questionnaire"
Description: "Donor questionnaire with all 33 source questions in Uzbek, Russian and English. Answers support clinical review and do not automatically establish deferral."
* url = "https://dhp.uz/fhir/integrations/Questionnaire/donor-questionnaire"
* name = "DonorQuestionnaire"
* language = #uz
* status = #draft
* experimental = true
* publisher = "Uzinfocom"
* subjectType = #Patient
* useContext[0].code = $usage-context-type#program
* useContext[0].valueCodeableConcept = $integration-area#blood-service
* title = "Donor so‘rovnomasi"
* title.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Анкета донора"
* title.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Donor questionnaire"
* description = "Qon topshirishdan oldin donorning anamnezi, roziligi va deklaratsiyalarini yig‘ish uchun so‘rovnoma."
* description.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Анкета для сбора анамнеза, согласий и подтверждений донора перед донацией."
* description.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Questionnaire collecting donor medical history, consents and declarations before donation."

// Gender, so the pregnancy questions are asked of women only
* item[+].linkId = "gender"
* item[=].type = #coding
* item[=].code = $loinc#107454-1
* item[=].required = true
* item[=].answerValueSet = "https://terminology.dhp.uz/fhir/core/ValueSet/administrative-gender-vs"
* item[=].text = "Jinsi"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Пол"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Gender"

// When was your last blood donation?
* item[+].linkId = "last-donation"
* item[=].type = #date
* item[=].code = $loinc#82756-8
* item[=].text = "Oxirgi marta qachon qon topshirgansiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Когда вы в последний раз сдавали кровь?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "When was your last blood donation?"

// When was your last visit to a doctor?
* item[+].linkId = "last-doctor-visit"
* item[=].type = #date
* item[=].text = "Oxirgi marta qachon shifokor qabulida bo‘lgansiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Когда в последний раз вы были на приёме у врача?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "When was your last visit to a doctor?"

// For what reason?
* item[+].linkId = "last-doctor-visit-reason"
* item[=].type = #text
* item[=].code = $loinc#29299-5
* item[=].text = "Shifokorga qaysi sababga ko‘ra murojaat qilgansiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "По какой причине вы обращались к врачу?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "What was the reason for that visit?"

// Are you feeling well today?
* item[+].linkId = "feeling-well"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#17326005
* item[=].text = "Bugun o‘zingizni yaxshi his qilyapsizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Хорошо ли вы себя чувствуете сегодня?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Are you feeling well today?"

// Do you have any chronic diseases (e.g. epilepsy, diabetes, cancer, or other long-term conditions)?
* item[+].linkId = "chronic-disease"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $loinc#97068-1
* item[=].text = "Sizda surunkali kasalliklar (masalan, epilepsiya, diabet, saraton yoki boshqa uzoq davom etadigan kasalliklar) bormi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Есть ли у вас хронические заболевания (например, эпилепсия, диабет, онкологические или другие длительные заболевания)?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Do you have any chronic diseases (e.g. epilepsy, diabetes, cancer, or other long-term conditions)?"

// Are you currently receiving regular medical treatment?
* item[+].linkId = "regular-treatment"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Hozirda muntazam davolanish kursini olayapsizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Получаете ли вы в настоящее время регулярное лечение?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Are you currently receiving regular medical treatment?"

// Do you regularly undergo any procedures or take any tablets/medicines?
* item[+].linkId = "medication-procedures"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#710814002
* item[=].text = "Muntazam ravishda biror muolajadan o‘tasizmi yoki dori tabletkalarini qabul qilasizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Регулярно ли принимаете какие-либо процедуры или таблетки?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Do you regularly undergo any procedures or take any tablets/medicines?"

// Have you ever had hepatitis or brucellosis?
* item[+].linkId = "hepatitis-brucellosis"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Siz ilgari gepatit yoki brutsellyoz bilan kasallanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Болели ли вы когда-либо гепатитом или бруцеллёзом?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you ever had hepatitis or brucellosis?"

// Has a doctor ever advised you not to donate blood?
* item[+].linkId = "advised-not-to-donate"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#897707000
* item[=].text = "Shifokor sizga ilgari qon topshirmaslikni tavsiya qilganmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Рекомендовал ли вам когда-либо врач не сдавать кровь?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Has a doctor ever advised you not to donate blood?"

// Have you undergone any dental procedures recently (during the last 2 weeks)?
* item[+].linkId = "dental-procedure"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi vaqtlarda (oxirgi 2 hafta ichida) stomatologik muolajalar o‘tkazilganmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Проводились ли вам стоматологические процедуры за последнее время (в течение последних 2 недель)?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you undergone any dental procedures recently (during the last 2 weeks)?"

// Have you had malaria during the last 3 weeks?
* item[+].linkId = "malaria-illness"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#161416007
* item[=].text = "So‘nggi 3 hafta ichida bezgak bilan kasallanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Болели ли малярией за последние 3 недели?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you had malaria during the last 3 weeks?"

// Have you been vaccinated during the last month?
* item[+].linkId = "vaccination"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#425457005
* item[=].text = "So‘nggi bir oy ichida emlanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Делали ли вам прививки в течение последнего месяца?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you been vaccinated during the last month?"

// During the last 3 months, have you experienced night sweats, unexplained weight loss, chills, diarrhoea, or enlarged lymph nodes?
* item[+].linkId = "recent-symptoms"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi 3 oy ichida tunda terlash, sababsiz vazn yo‘qotish, titroq, ich ketishi yoki limfa tugunlarining kattalashishi kuzatilganmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Были ли у вас в течение последних 3 месяцев ночная потливость, необъяснимая потеря веса, озноб, диарея или увеличение лимфатических узлов?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "During the last 3 months, have you experienced night sweats, unexplained weight loss, chills, diarrhoea, or enlarged lymph nodes?"

// Have you been in contact with a person infected with hepatitis or HIV/AIDS?
* item[+].linkId = "infected-contact"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Gepatit yoki OIV/OITS bilan kasallangan shaxs bilan aloqada bo‘lganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Были в контакте с человеком, заражённым гепатитом или ВИЧ/СПИД?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you been in contact with a person infected with hepatitis or HIV/AIDS?"

// Have you had casual unprotected sexual contact during the last 6 months?
* item[+].linkId = "unprotected-sex"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#2314005
* item[=].text = "So‘nggi 6 oy ichida tasodifiy himoyalanmagan jinsiy aloqada bo‘lganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Были ли у вас случайные незащищённые половые контакты в течение последних 6 месяцев?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you had casual unprotected sexual contact during the last 6 months?"

// Have you been hospitalized during the last 6 months?
* item[+].linkId = "hospitalization"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $loinc#93680-7
* item[=].text = "So‘nggi 6 oy ichida shifoxonaga yotqizilganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "За последние 6 месяцев: госпитализации?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you been hospitalized during the last 6 months?"

// Have you undergone surgery, a medical intervention, or an endoscopic procedure during the last 6 months?
* item[+].linkId = "surgery"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#161615003
* item[=].text = "So‘nggi 6 oy ichida jarrohlik amaliyoti, tibbiy muolaja yoki endoskopik tekshiruvdan o‘tganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Переносили ли вы хирургическое вмешательство, медицинскую процедуру или эндоскопическое исследование в течение последних 6 месяцев?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you undergone surgery, a medical intervention, or an endoscopic procedure during the last 6 months?"

// Have you ever received a blood transfusion or blood components?
* item[+].linkId = "blood-transfusion"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#161664006
* item[=].text = "Sizga ilgari qon yoki uning tarkibiy qismlari quyilganmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Получали ли вы когда-либо переливание крови или её компонентов?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you ever received a blood transfusion or blood components?"

// Have you been treated for sexually transmitted infections such as syphilis, gonorrhoea, chlamydia, genital ulcers, or herpes?
* item[+].linkId = "sti-treatment"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#275881005
* item[=].text = "Sifilis, gonoreya, xlamidioz, jinsiy a’zolardagi yaralar yoki gerpes kabi jinsiy yo‘l bilan yuqadigan infeksiyalardan davolanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Проходили лечение от венерических инфекций: сифилис, гонорея, хламидиоз, генитальные язвы, герпес?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you been treated for sexually transmitted infections such as syphilis, gonorrhoea, chlamydia, genital ulcers, or herpes?"

// Have you used shared needles, syringes, or scarifiers?
* item[+].linkId = "shared-needles"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#228400001
* item[=].text = "Umumiy ignalar, shpritslar yoki skarifikatorlardan foydalanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Использовали общие иглы, шприцы или скарификаторы?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you used shared needles, syringes, or scarifiers?"

// Have you had a tattoo, piercing, or acupuncture during the last 6 months?
* item[+].linkId = "tattoo-piercing"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi 6 oy ichida tatuirovka, pirsing yoki igna bilan davolash (akupunktura) muolajasini olganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "За последние 6 месяцев: тату, пирсинг или иглоукалывание?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you had a tattoo, piercing, or acupuncture during the last 6 months?"

// Have you been in places of detention or imprisonment?
* item[+].linkId = "incarceration"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#266944002
* item[=].text = "Ozodlikdan mahrum etish joylarida bo‘lganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Были в местах лишения свободы?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you been in places of detention or imprisonment?"

// Do you consent to testing your blood for HIV/AIDS, hepatitis, and syphilis?
* item[+].linkId = "testing-consent"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Qoningizni OIV/OITS, gepatit va sifilisga tekshirishga rozimisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Даёте согласие на тестирование крови на ВИЧ/СПИД, гепатит, сифилис?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Do you consent to testing your blood for HIV/AIDS, hepatitis, and syphilis?"

// What else can you add about your health?
* item[+].linkId = "additional-health"
* item[=].type = #text
* item[=].text = "Sog‘lig‘ingiz haqida yana nimalarni qo‘shimcha qilishingiz mumkin?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Что ещё можете добавить о своём здоровье?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "What else can you add about your health?"

// Would you like to donate blood regularly?
* item[+].linkId = "regular-donation-preference"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $sct#160655006
* item[=].text = "Muntazam ravishda qon topshirishni xohlaysizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Хотите ли регулярно сдавать кровь?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Would you like to donate blood regularly?"

// May we contact you in the future?
* item[+].linkId = "contact-consent"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Kelgusida siz bilan bog‘lanishimiz mumkinmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Можем ли мы связаться с Вами в будущем?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "May we contact you in the future?"

// Have you recently had influenza, an acute respiratory viral infection (ARVI), or a sore throat?
* item[+].linkId = "flu-arvi"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi vaqtlarda gripp, O‘RVI yoki angina bilan kasallanganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "В последнее время: грипп, ОРВИ или ангина?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you recently had influenza, an acute respiratory viral infection (ARVI), or a sore throat?"

// Have you travelled abroad during the last 6 months?
* item[+].linkId = "travel-abroad"
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $loinc#8691-8
* item[=].text = "So‘nggi 6 oy ichida chet elga safar qilganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "За последние 6 месяцев выезжали ли вы за границу?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you travelled abroad during the last 6 months?"

// During the last 3 weeks, have you had a fever or visited malaria-risk areas?
* item[+].linkId = "malaria-exposure"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi 3 hafta ichida isitma kuzatildimi yoki bezgak xavfi mavjud hududlarga borganmisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "За последние 3 недели: температура или посещение регионов с малярией?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "During the last 3 weeks, have you had a fever or visited malaria-risk areas?"

// Are you pregnant?
* item[+].linkId = "pregnancy"
* item[=].enableWhen[+].question = "gender"
* item[=].enableWhen[=].operator = #!=
* item[=].enableWhen[=].answerCoding = $gender#male
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $loinc#82810-3
* item[=].text = "Homiladormisiz?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Вы беременны?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Are you pregnant?"

// Have you given birth or had a miscarriage in the last 6 months?
* item[+].linkId = "postpartum-miscarriage"
* item[=].enableWhen[+].question = "gender"
* item[=].enableWhen[=].operator = #!=
* item[=].enableWhen[=].answerCoding = $gender#male
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi 6 oy ichida tug‘ruq yoki homila tushishi bo‘lganmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "За последние 6 месяцев были роды или выкидыш?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Have you given birth or had a miscarriage in the last 6 months?"

// Are you currently breastfeeding?
* item[+].linkId = "breastfeeding"
* item[=].enableWhen[+].question = "gender"
* item[=].enableWhen[=].operator = #!=
* item[=].enableWhen[=].answerCoding = $gender#male
* item[=].type = #boolean
* item[=].required = true
* item[=].code = $loinc#63895-7
* item[=].text = "Hozirda bolangizni emizyapsizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "В настоящее время кормите ли вы грудью?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Are you currently breastfeeding?"

// I confirm that I have not consumed alcohol in the last 48 hours and have not taken aspirin or other analgesics in the last 72 hours.
* item[+].linkId = "alcohol-medication-declaration"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "So‘nggi 48 soat ichida alkogol iste’mol qilmaganligimni va so‘nggi 72 soat ichida aspirin va analgetiklar qabul qilmaganligimni tasdiqlayman"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Подтверждаю, что в течение последних 48 часов не употреблял(а) алкоголь, а в течение последних 72 часов не принимал(а) аспирин или другие анальгетики."
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "I confirm that I have not consumed alcohol in the last 48 hours and have not taken aspirin or other analgesics in the last 72 hours."

// Do you confirm that you understood these questions and the reason for asking them, and that you answered honestly?
* item[+].linkId = "declaration"
* item[=].type = #boolean
* item[=].required = true
* item[=].text = "Ushbu savollarni va ularning berilish sababini tushunganingizni hamda ularga vijdonan javob berganingizni tasdiqlaysizmi?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #ru
  * extension[content].valueString = "Подтверждаете, что поняли данные вопросы, причину их задавания, и ответили добросовестно?"
* item[=].text.extension[$translation-extension][+]
  * extension[lang].valueCode = #en
  * extension[content].valueString = "Do you confirm that you understood these questions and the reason for asking them, and that you answered honestly?"
