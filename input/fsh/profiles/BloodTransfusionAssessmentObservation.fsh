Profile: BloodTransfusionAssessmentObservation
Parent: UZCoreObservation
Id: blood-transfusion-assessment-observation
Title: "Blood Transfusion Assessment Observation"
Description: "Integration Observation profile for the compatibility tests made between a recipient and one blood unit before and at the start of a transfusion."
* ^status = #draft
* ^experimental = true

* status ^comment = "Use final for a completed assessment. Correct results by updating the same Observation, for example with status amended."
* code = $sct#252314007
* code ^short = "Blood transfusion test"
* subject 1..1
* subject only Reference(UZCorePatient)
* subject ^short = "Recipient of the blood component"
* focus 0..1 MS
* focus only Reference(UZCoreBiologicallyDerivedProduct)
* focus ^short = "Blood unit tested against the recipient"
* effective[x] ^short = "Actual time or period of the assessment"
* issued ^short = "When this version of the result became available"
* value[x] 0..0
* derivedFrom ^short = "Recipient history and blood group used for the assessment"
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component contains
    aboCompatibility 0..1 MS and
    rhHrCompatibility 0..1 MS and
    biologicalTest 0..1 MS

* component[aboCompatibility] ^short = "ABO compatibility"
* component[aboCompatibility].code = BloodTransfusionAssessmentCS#bldcomp-0001-00001
* component[aboCompatibility].value[x] only CodeableConcept
* component[aboCompatibility].valueCodeableConcept from BloodCompatibilityResultVS (required)

* component[rhHrCompatibility] ^short = "Rh-Hr compatibility"
* component[rhHrCompatibility].code = BloodTransfusionAssessmentCS#bldcomp-0001-00002
* component[rhHrCompatibility].value[x] only CodeableConcept
* component[rhHrCompatibility].valueCodeableConcept from BloodCompatibilityResultVS (required)

* component[biologicalTest] ^short = "Biological compatibility test result"
* component[biologicalTest].code = BloodTransfusionAssessmentCS#bldcomp-0001-00006
* component[biologicalTest].value[x] only CodeableConcept
* component[biologicalTest].valueCodeableConcept from positive-negative-result-vs (required)
