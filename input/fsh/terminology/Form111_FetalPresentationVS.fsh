ValueSet: Form111_FetalPresentationVS
Id: form111-fetal-presentation-vs
Title: "Form 111 Fetal Presentation ValueSet"
Description: "Form 111 Fetal Presentation ValueSet for clinical documents and other knowledge resources in Uzbekistan integrations. Based on Ministry of Health Order 399."
* insert IntegrationsValueSet(form111-fetal-presentation-vs)

* include codes from system form111-fetal-presentation-cs

// Standard equivalent for the explicit DMED token; local codes remain accepted for compatibility.
* $sct#1209182005 "Cephalic fetal presentation"

* ^experimental = true
* ^status = #draft 