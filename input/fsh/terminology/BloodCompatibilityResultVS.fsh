ValueSet: BloodCompatibilityResultVS
Id: blood-compatibility-result-vs
Title: "Blood compatibility result"
Description: "Results of the ABO and Rh-Hr compatibility tests made before a blood transfusion"
* insert IntegrationsValueSet(blood-compatibility-result-vs)
* ^status = #draft
* ^experimental = true
* $sct#250405008 "Blood compatible"
* $sct#250406009 "Blood incompatible"
