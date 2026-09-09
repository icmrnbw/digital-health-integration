CodeSystem: Form096MaritalStatusFormCS
Id: marital-status-form-cs
Title: "Marital Status for CHR Forms CodeSystem"
Description: "Governed local concepts for Form 096, generated from the approved Google Sheet terminology table."
* ^url = "https://terminology.dhp.uz/fhir/integrations/CodeSystem/marital-status-form-cs"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* ^hierarchyMeaning = #is-a
* ^language = #uz

* #chr-0041-0001 "Turmush qurgan"
  * ^designation[0].language = #en
  * ^designation[=].value = "Married"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Замужем"

* #chr-0041-0002 "Turmush qurmagan"
  * ^designation[0].language = #en
  * ^designation[=].value = "Unmarried"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Не замужем"
