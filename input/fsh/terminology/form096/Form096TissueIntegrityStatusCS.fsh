CodeSystem: Form096TissueIntegrityStatusCS
Id: tissue-integrity-status-cs
Title: "Tissue Integrity Status CodeSystem"
Description: "Governed local concepts for Form 096, generated from the approved Google Sheet terminology table."
* ^url = "https://terminology.dhp.uz/fhir/chr/CodeSystem/tissue-integrity-status-cs"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* ^hierarchyMeaning = #is-a
* ^language = #uz

* #chr-0048-0001 "Butun"
  * ^designation[0].language = #en
  * ^designation[=].value = "Intact"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Целостный"

* #chr-0048-0002 "Butunligi buzilgan"
  * ^designation[0].language = #en
  * ^designation[=].value = "Integrity compromised"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Целостность нарушена"
