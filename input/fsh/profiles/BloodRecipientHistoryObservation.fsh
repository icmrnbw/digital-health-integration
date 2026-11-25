Profile: BloodRecipientHistoryObservation
Parent: UZCoreObservation
Id: blood-recipient-history-observation
Title: "Blood Recipient History Observation"
Description: "Integration Observation profile for the transfusion history or the obstetric history taken from a recipient before a blood transfusion."
* ^status = #draft
* ^experimental = true

* code from BloodRecipientHistoryTypeVS (required)
* code ^short = "Transfusion history or obstetric history"
* subject 1..1
* subject only Reference(UZCorePatient)
* subject ^short = "Recipient of the blood component"
* value[x] only CodeableConcept
* valueCodeableConcept MS
* valueCodeableConcept ^short = "History category, from the value set that matches the code"
* valueCodeableConcept ^binding.strength = #required
* valueCodeableConcept ^binding.description = "The value set depends on the code: transfusion history categories for a transfusion history, obstetric history categories for an obstetric history"
* valueCodeableConcept ^binding.additional[+].purpose = #required
* valueCodeableConcept ^binding.additional[=].valueSet = Canonical(BloodTransfusionHistoryVS)
* valueCodeableConcept ^binding.additional[=].usage.code = https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation#Observation.code
* valueCodeableConcept ^binding.additional[=].usage.valueCodeableConcept = BloodTransfusionAssessmentCS#bldcomp-0001-00003
* valueCodeableConcept ^binding.additional[+].purpose = #required
* valueCodeableConcept ^binding.additional[=].valueSet = Canonical(BloodRecipientObstetricHistoryVS)
* valueCodeableConcept ^binding.additional[=].usage.code = https://dhp.uz/fhir/integrations/StructureDefinition/blood-recipient-history-observation#Observation.code
* valueCodeableConcept ^binding.additional[=].usage.valueCodeableConcept = BloodTransfusionAssessmentCS#bldcomp-0001-00004
* dataAbsentReason ^short = "Why there is no value, e.g. not-applicable for a recipient with no obstetric history"
* component 0..0
