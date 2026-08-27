ValueSet: ScreeningDiabetesVS
Id: screening-diabetes-vs
Title: "Screening Diabetes ValueSet"
Description: "Value set containing Screening Diabetes Codes"
* insert IntegrationsValueSet(screening-diabetes-vs)
* ^experimental = true

* include codes from system screening-diabetes-cs
