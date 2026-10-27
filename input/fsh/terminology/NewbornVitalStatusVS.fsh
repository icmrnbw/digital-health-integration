ValueSet: NewbornVitalStatusVS
Id: newborn-vital-status-vs
Title: "Newborn Vital Status ValueSet"
Description: "Birth outcome of the newborn for Form097 newborn development record. Source terminology (SNOMED CT) reused directly."
* insert IntegrationsValueSet(newborn-vital-status-vs)
* ^experimental = true

// Birth outcome is distinct from death after livebirth.
* include $sct#281050002 "Livebirth"
* include $sct#237364002 "Stillbirth"
