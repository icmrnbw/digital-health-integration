ValueSet: BloodRecipientObstetricHistoryVS
Id: blood-recipient-obstetric-history-vs
Title: "Blood recipient obstetric history category"
Description: "Obstetric history categories recorded for a blood transfusion recipient"
* insert IntegrationsValueSet(blood-recipient-obstetric-history-vs)
* ^status = #draft
* ^experimental = true
* include codes from system BloodRecipientObstetricHistoryCS
