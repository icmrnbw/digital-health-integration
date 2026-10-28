Profile: Form096MaternityMedicalRecordComposition
Parent: Composition
Id: form-096-maternity-medical-record-composition
Title: "Form 096 - Maternity Medical Record Composition"
Description: "FHIR R5 Composition for Form 096 (Tug'ruq tibbiy kartasi), based on the Form 096 integration document. The mapping workbook provides supporting traceability."

* identifier 1..*
* identifier ^short = "Form 096 maternity medical-record number"
* status = #final
* type = $loinc#57057-2 "Labor and Delivery Summary Note"
* type ^short = "Form 096 maternity medical record"
* category 1..1
* category = $document-category-cs#form-096
* subject 1..1
* subject only Reference(UZCorePatient)
* encounter 1..1
* encounter only Reference(UZCoreEncounter)
* author 1..*
* author only Reference(UZCorePractitionerRole or UZCorePractitioner)
* custodian only Reference(UZCoreOrganization)

* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
// Optional clinical sections: do not synthesize absent DMED data.
// A present section keeps its discriminator code and the base FHIR invariants.
* section contains
    admissionInformation 0..1 and
    medicalAndObstetricHistory 0..1 and
    currentPregnancy 0..1 and
    obstetricExamination 0..1 and
    laborCourse 0..1 and
    newbornDeliveryRecord 0..1 and
    postpartumPeriod 0..1 and
    medicationOrders 0..1 and
    diagnosticOrders 0..1 and
    procedureOrders 0..1 and
    usedMaterials 0..1 and
    sickLeaveCertificates 0..1 and
    responsiblePersons 0..1

// Document identifiers, demographics, admission/discharge, laboratory values,
// diagnoses, complications, operations, and disposition.
* section[admissionInformation].code 1..1
* section[admissionInformation].code = $loinc#LP74442-2 "Admission Information"
* section[admissionInformation].entry only Reference(UZCorePatient or UZCoreEncounter or UZCoreOrganization or UZCoreObservation or UZCoreCondition or UZCoreProcedure or UZCoreAllergyIntolerance)

// General diseases, spouse health, menstrual/sexual/gynecological history, and
// previous pregnancies, births, abortions, operations, newborn weights and outcomes,
// occupation, and the epidemiological history in the history QuestionnaireResponse.
* section[medicalAndObstetricHistory].code 1..1
* section[medicalAndObstetricHistory].code = $loinc#11329-0 "History general Narrative - Reported"
// Clinical sections are optional; omit a section when its source data are absent.
* section[medicalAndObstetricHistory].entry only Reference(UZCoreRelatedPerson or UZCoreObservation or UZCoreSocioeconomicObservation or UZCoreCondition or UZCoreProcedure or UZCoreQuestionnaireResponse)


// Course/complications of the current pregnancy and general physical examination.
* section[currentPregnancy].code 1..1
* section[currentPregnancy].code = $loinc#65869-0 "Pregnancy complication"
* section[currentPregnancy].entry only Reference(UZCoreObservation or UZCoreCondition or UZCoreQuestionnaireResponse)

// Maternal measurements, pelvimetry, pregnancy counts and fetal assessment, one Observation per fetus.
* section[obstetricExamination].code 1..1
* section[obstetricExamination].code = $sct#163497009 "Obstetric examination"
* section[obstetricExamination].entry only Reference(UZCoreObservation)

// Labor onset, rupture of membranes, dilation, pushing, support and duration.
* section[laborCourse].code 1..1
* section[laborCourse].code = $loinc#57074-7 "Labor and delivery process Narrative"
* section[laborCourse].entry only Reference(UZCoreObservation or UZCoreProcedure or MedicationAdministration)

// Each newborn, birth measurements, presentation, Apgar, placenta, membranes and cord.
* section[newbornDeliveryRecord].code 1..1
* section[newbornDeliveryRecord].code = $loinc#57075-4 "Newborn delivery information"
* section[newbornDeliveryRecord].entry only Reference(UZCorePatient or UZCoreObservation or UZCoreCondition or UZCoreProcedure or UZCoreImmunization)
* section[newbornDeliveryRecord].entry ^definition = "Include a separate UZCorePatient for each newborn. When PINFL is absent, use the newborn's DMED medical-card number in Patient.identifier[healthCardId], using the UZ Core HC identifier system. Individual measurements and Apgar assessments reference that newborn as Observation.subject; delivery-wide counts reference the mother. Reuse the same patient identity in Form 097 and add PINFL to that identity when available."

// Repeating postpartum observation rows.
* section[postpartumPeriod].code 1..1
* section[postpartumPeriod].code = $sct#133906008 "Postpartum care"
* section[postpartumPeriod].entry only Reference(UZCoreObservation)

* section[medicationOrders].code 1..1
* section[medicationOrders].code = $loinc#29549-3 "Medication administered Narrative"
* section[medicationOrders].entry only Reference(UZCoreMedicationRequest or MedicationAdministration or UZCoreObservation)

* section[diagnosticOrders].code 1..1
* section[diagnosticOrders].code = $loinc#18776-5 "Plan of care note"
* section[diagnosticOrders].entry only Reference(UZCoreServiceRequest or UZCoreObservation)

* section[procedureOrders].code 1..1
* section[procedureOrders].code = $loinc#29554-3 "Procedure Narrative"
* section[procedureOrders].entry only Reference(UZCoreServiceRequest or UZCoreProcedure)

* section[usedMaterials].code 1..1
* section[usedMaterials].code = $loinc#46264-8 "History of medical device use"
* section[usedMaterials].entry only Reference(UZCoreSupplyDelivery)

// Sick-leave certificates shown on the title sheet are represented by the
// existing SickLeaveCarePlan profile and may repeat for one hospitalization.
* section[sickLeaveCertificates].code 1..1
* section[sickLeaveCertificates].code = $loinc#34109-9 "Note"
* section[sickLeaveCertificates].entry only Reference(SickLeaveCarePlan)

* section[responsiblePersons].code 1..1
* section[responsiblePersons].code = $loinc#51899-3 "Details Document"
* section[responsiblePersons].entry only Reference(UZCorePractitionerRole or UZCoreProvenance)
