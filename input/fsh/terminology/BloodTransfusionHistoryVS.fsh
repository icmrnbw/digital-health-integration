ValueSet: BloodTransfusionHistoryVS
Id: blood-transfusion-history-vs
Title: "Blood transfusion history category"
Description: "Blood transfusion history categories recorded for a blood transfusion recipient"
* insert IntegrationsValueSet(blood-transfusion-history-vs)
* ^status = #draft
* ^experimental = true
* include codes from system BloodTransfusionHistoryCS
* $sct#7831000175106 "History of reaction to blood transfusion"
