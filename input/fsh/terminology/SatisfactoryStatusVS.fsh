ValueSet: SatisfactoryStatusVS
Id: satisfactory-status-vs
Title: "Satisfactory Status ValueSet"
Description: "General condition: satisfactory or unsatisfactory, the same SNOMED CT codes as Form 111."
* insert IntegrationsValueSet(satisfactory-status-vs)
* ^experimental = true

* include $sct#162669003 "Patient's condition satisfactory"
* include $sct#162667001 "Patient's condition poor"
