Instance: example-blood-transfusion-assessment
InstanceOf: BloodTransfusionAssessmentObservation
Title: "Example Blood Transfusion Assessment Observation - Compatible Red Cell Unit"
Description: "Compatibility tests between the registered recipient and one red cell unit, derived from the recipient's transfusion history and blood group."
Usage: #example
* language = #uz
* status = #final
* code = $sct#252314007 "Blood transfusion test"
* subject = Reference(Patient/example-patient-john)
* encounter = Reference(example-transfusion-assessment-encounter)
* focus = Reference(BiologicallyDerivedProduct/example-blood-component-product)
* effectiveDateTime = "2026-11-11T10:30:00+05:00"
* issued = "2026-11-11T10:35:00+05:00"
* performer = Reference(example-transfusion-assessment-practitioner)
* derivedFrom[+] = Reference(example-blood-recipient-transfusion-history)
* derivedFrom[+] = Reference(example-blood-recipient-blood-group)
* component[aboCompatibility].code = BloodTransfusionAssessmentCS#bldcomp-0001-00001 "ABO bo‘yicha moslik"
* component[aboCompatibility].valueCodeableConcept = $sct#250405008 "Blood compatible"
* component[rhHrCompatibility].code = BloodTransfusionAssessmentCS#bldcomp-0001-00002 "Rh-Hr bo‘yicha moslik"
* component[rhHrCompatibility].valueCodeableConcept = $sct#250405008 "Blood compatible"
* component[biologicalTest].code = BloodTransfusionAssessmentCS#bldcomp-0001-00006 "Biologik sinama"
* component[biologicalTest].valueCodeableConcept = $sct#260385009 "Negative"

Instance: example-blood-recipient-transfusion-history
InstanceOf: BloodRecipientHistoryObservation
Title: "Example Blood Recipient History Observation - No Previous Transfusions"
Description: "Transfusion history taken from the registered recipient before the transfusion."
Usage: #example
* language = #uz
* status = #final
* code = BloodTransfusionAssessmentCS#bldcomp-0001-00003 "Transfuzion anamnez"
* subject = Reference(Patient/example-patient-john)
* encounter = Reference(example-transfusion-assessment-encounter)
* effectiveDateTime = "2026-11-11T10:10:00+05:00"
* performer = Reference(example-transfusion-assessment-practitioner)
* valueCodeableConcept = BloodTransfusionHistoryCS#bldcomp-0003-00001 "Avval qon quyilmagan"

Instance: example-blood-recipient-obstetric-history
InstanceOf: BloodRecipientHistoryObservation
Title: "Example Blood Recipient History Observation - Obstetric History Not Applicable"
Description: "Obstetric history that does not apply to the recipient, sent with a data absent reason instead of a value."
Usage: #example
* language = #uz
* status = #final
* code = BloodTransfusionAssessmentCS#bldcomp-0001-00004 "Akusherlik anamnezi"
* subject = Reference(Patient/example-patient-john)
* encounter = Reference(example-transfusion-assessment-encounter)
* effectiveDateTime = "2026-11-11T10:10:00+05:00"
* performer = Reference(example-transfusion-assessment-practitioner)
* dataAbsentReason = $data-absent-reason#not-applicable "Not Applicable"

Instance: example-blood-recipient-blood-group
InstanceOf: UZCoreObservation
Title: "Example UZ Core Observation - Recipient Preliminary ABO Group"
Description: "Preliminary ABO group of the recipient, determined at the bedside before the transfusion."
Usage: #example
* language = #uz
* status = #preliminary
* code = $loinc#883-9 "Qonda ABO guruhi turi"
* subject = Reference(Patient/example-patient-john)
* encounter = Reference(example-transfusion-assessment-encounter)
* effectiveDateTime = "2026-11-11T10:20:00+05:00"
* performer = Reference(example-transfusion-assessment-practitioner)
* valueCodeableConcept = $sct#112144000 "Blood group A"

Instance: example-transfusion-assessment-practitioner
InstanceOf: UZCorePractitioner
Title: "Example UZ Core Practitioner - Transfusion Assessor"
Description: "Synthetic practitioner responsible for the pre-transfusion assessment."
Usage: #example
* language = #uz
* active = true
* name.use = #official
* name.family = "Rasulov"
* name.given = "Bahodir"

Instance: example-transfusion-assessment-encounter
InstanceOf: UZCoreEncounter
Title: "Example UZ Core Encounter - Transfusion"
Description: "Treatment encounter in which the registered recipient is assessed and transfused."
Usage: #example
* language = #uz
* status = #in-progress
* type[nationalType] = $encounter-type-cs#mserv-0001-00004 "Davolash"
* subject = Reference(Patient/example-patient-john)
* actualPeriod.start = "2026-11-11T10:00:00+05:00"
* participant.actor = Reference(example-transfusion-assessment-practitioner)
