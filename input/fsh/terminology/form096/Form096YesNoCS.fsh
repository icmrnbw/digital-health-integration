CodeSystem: Form096YesNoCS
Id: yes-no-cs
Title: "Yes / No CodeSystem"
Description: "Governed local concepts for Form 096, generated from the approved Google Sheet terminology table."
* ^url = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/yes-no-cs"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* ^hierarchyMeaning = #is-a
* ^language = #uz

* #chr-0039-0001 "Ha"
  * ^designation[0].language = #en
  * ^designation[=].value = "Yes"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Да"

* #chr-0039-0002 "Yo‘q"
  * ^designation[0].language = #en
  * ^designation[=].value = "No"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Нет"
