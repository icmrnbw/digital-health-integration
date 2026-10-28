CodeSystem: ScreeningActionTranslationsCS
Id: screening-action-translations-cs
Title: "Screening action code translations"
Description: "Action code supplement with translations in Uzbek and Russian. Not yet referenced by any ValueSet."
* insert SupplementCodeSystemDraft(screening-action-translations-cs, $action-code, 5.0.0)

* #order-service
  * ^designation[0].language = #ru
  * ^designation[=].value = "Назначить медицинскую услугу"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Tibbiy xizmatni tayinlash"
