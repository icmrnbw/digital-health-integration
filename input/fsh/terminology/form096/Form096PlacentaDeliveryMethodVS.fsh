ValueSet: Form096PlacentaDeliveryMethodVS
Id: placenta-delivery-method-vs
Title: "Placenta Delivery Method"
Description: "Form 096 terminology binding for Procedure.code. Covers both how the placenta separated and how it was delivered."
* ^url = "https://terminology.dhp.uz/fhir/integrations/ValueSet/placenta-delivery-method-vs"
* ^status = #active
* ^experimental = true
* include $form096-placenta-delivery-method-cs#chr-0086-0001 "Expelled"
* include $form096-placenta-delivery-method-cs#chr-0086-0002 "Separated spontaneously"
* include $sct#177204008 "Manual removal of placenta from delivered uterus"
* include $form096-placenta-delivery-method-cs#chr-0086-0004 "Removed instrumentally"
