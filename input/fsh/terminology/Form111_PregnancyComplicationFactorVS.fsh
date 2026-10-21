ValueSet: Form111_PregnancyComplcationFactorVS
Id: form111-pregnancy-complication-factor-vs
Title: "Pregnancy Complication Factor ValueSet"
Description: "Form 111 Pregnancy Complication Factor ValueSet"
* insert IntegrationsValueSet(form111-pregnancy-complication-factor-vs)

* include codes from system form111-pregnancy-complication-factor-cs

// Standard equivalent for the explicit DMED token; local codes remain accepted for compatibility.
* $sct#271737000 "Anemia"

* ^experimental = true
* ^status = #draft