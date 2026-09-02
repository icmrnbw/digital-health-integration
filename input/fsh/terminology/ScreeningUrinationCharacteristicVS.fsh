ValueSet: ScreeningUrinationCharacteristicVS
Id: screening-urination-characteristic-vs
Title: "Screening Urination Characteristic ValueSet"
Description: "Defines Screening Urination Characteristic"
* insert IntegrationsValueSet(screening-urination-characteristic-vs)
* ^experimental = true
* ^language = #uz
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(ScreeningObservationCodesCS)
* include $sct#102834005
* include $sct#49650001
* include $sct#102835006
* include codes from system screening-urination-characteristic-cs
