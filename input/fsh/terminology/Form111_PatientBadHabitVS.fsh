ValueSet: Form111_PatientBadHabitVS
Id: form111-patient-bad-habit-vs
Title: "Form 111 Patient Bad Habits ValueSet"
Description: "Form 111 Patient Bad Habits ValueSet"
* insert IntegrationsValueSet(form111-patient-bad-habit-vs)

* include codes from system form111-patient-bad-habit-cs

// Standard equivalent for the explicit DMED token; local codes remain accepted for compatibility.
* $sct#77176002 "Smoker"

* ^experimental = true
* ^status = #draft