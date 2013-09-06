# An order for both supply of the medication and the
# instructions for administration of the medicine to a
# patient.
class Fhir::MedicationPrescription < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External identifier
  attribute :identifiers, Array[Fhir::Identifier]

  # Prescription date
  attribute :date_written, DateTime

  # active | paused | completed | nullified
  attribute :status, Fhir::Code

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Prescriber
  resource_reference :prescriber, [Fhir::Practitioner]

  # Encounter / Admission / Stay
  resource_reference :encounter, [Fhir::Encounter]

  # Reason or indication for writing the prescription
  attribute :reason_for_prescribing, *Fhir::Type[String, Fhir::CodeableConcept]

  # Medication to be taken
  resource_reference :medication, [Fhir::Medication]

  # Indicates how the medication is to be used by the patient.
  class DosageInstruction < Fhir::ValueObject
    # Dosage text
    attribute :dosage_instructions_text, String

    # Additional dosage instructions
    attribute :additional_instructions, *Fhir::Type[String, Fhir::CodeableConcept]

    # Medication timing
    attribute :timing, *Fhir::Type[DateTime, Fhir::Period, Fhir::Schedule]

    # Entry site
    attribute :site, Fhir::CodeableConcept

    # Route of administration
    attribute :route, Fhir::CodeableConcept

    # Administration method
    attribute :method, Fhir::CodeableConcept

    # Dose quantity per dose
    attribute :dose_quantity, Fhir::Quantity

    # Dose quantity per unit of time
    attribute :rate, Fhir::Ratio

    # Total dose that should be consumed per unit of time
    attribute :max_dose_per_period, Fhir::Ratio
  end

  attribute :dosage_instructions, Array[DosageInstruction]

  # Deals with details of the dispense part of the order.
  class Dispense < Fhir::ValueObject
    # Medication to be dispensed
    resource_reference :medication, [Fhir::Medication]

    # Validity period
    attribute :validity_period, Fhir::Period

    # Number of repeats allowed
    attribute :number_of_repeats_allowed, Integer

    # Quanity
    attribute :quantity, Fhir::Quantity

    # Expected supply duration
    attribute :expected_supply_duration, Fhir::Quantity
  end

  attribute :dispense, Dispense

  # Indicates whether or not substitution can or should as
  # part of the dispense.  In some cases substitution must 
  # happen, in other cases substitution must not happen, and in
  # others it does not matter.  This block explains the
  # prescribers intent.  If nothing is specified substitution
  # may be done.
  class Substitution < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # Type of substitiution
    # Should be present
    attribute :type, Fhir::CodeableConcept

    # Why should substitution (not) be made
    attribute :reason, Fhir::CodeableConcept
  end

  attribute :substitution, Substitution
end

