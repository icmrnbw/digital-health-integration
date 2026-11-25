CodeSystem: BloodRecipientObstetricHistoryCS
Id: blood-recipient-obstetric-history-cs
Title: "Blood recipient obstetric history categories"
Description: "Local categories describing the recipient's obstetric history."
* insert OriginalCodeSystemDraft(blood-recipient-obstetric-history-cs)

* #bldcomp-0004-00002 "Homiladorlik yoki tug‘ruq bo‘lmagan"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Беременностей/родов не было"
  * ^designation[+].language = #en
  * ^designation[=].value = "No pregnancies or births"
* #bldcomp-0004-00003 "Asoratsiz homiladorliklar"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Беременности без осложнений"
  * ^designation[+].language = #en
  * ^designation[=].value = "Pregnancies without complications"
* #bldcomp-0004-00004 "Asoratlar bilan kechgan homiladorliklar"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Беременности с осложнениями"
  * ^designation[+].language = #en
  * ^designation[=].value = "Pregnancies with complications"
