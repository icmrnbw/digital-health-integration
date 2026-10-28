ValueSet: Form096TissueIntegrityStatusVS
Id: tissue-integrity-status-vs
Title: "Placenta and Membranes Completeness"
Description: "Form 096 terminology binding for Observation.valueCodeableConcept of the placenta completeness (SNOMED CT 364343000) and membranes completeness (SNOMED CT 364351002) components."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/tissue-integrity-status-vs"
* ^status = #active
* ^experimental = true
* include $sct#249170006 "Complete placenta at delivery"
* include $sct#268479002 "Incomplete placenta at delivery"
* include $sct#249181009 "Membranes complete"
* include $sct#249182002 "Membranes incomplete"
