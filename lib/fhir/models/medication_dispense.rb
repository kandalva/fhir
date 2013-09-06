# Dispensing a medication to a named patient.  This includes
# a description of the supply provided and the instructions
# for administering the medication.
class Fhir::MedicationDispense < Fhir::Resource
  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # External identifier
  attribute :identifier, Fhir::Identifier

  # active | paused | completed | nullified
  attribute :status, Fhir::Code

  # Patient
  resource_reference :patient, [Fhir::Patient]

  # Dispenser
  resource_reference :dispenser, [Fhir::Practitioner]

  # Medication order that authorises the dispense
  resource_references :authorizing_prescriptions, [Fhir::MedicationPrescription]

  # Indicates the details of the dispense event such as the
  # days supply and quantity of medication dispensed.
  class Dispense < Fhir::ValueObject
    # External identifier
    attribute :identifier, Fhir::Identifier

    # Active/Completed/Aborted
    attribute :status, Fhir::Code

    # Type of dispense
    attribute :type, Fhir::CodeableConcept

    # Amount dispensed
    attribute :quantity, Fhir::Quantity

    # Medication
    resource_reference :medication, [Fhir::Medication]

    # Dispensing time
    attribute :when_prepared, Fhir::Period

    # Handover time
    attribute :when_handed_over, Fhir::Period

    # Where the medication was sent
    resource_reference :destination, [Fhir::Location]

    # Who collected the medication
    resource_references :receivers, [Fhir::Practitioner]

    # Indicates how the medication is to be used by the patient.
    class Dosage < Fhir::ValueObject
      # Additional dosage instructions
      attribute :additional_instructions, *Fhir::Type[String, Fhir::CodeableConcept]

      # Medication timing
      attribute :timing, *Fhir::Type[DateTime, Fhir::Period, Fhir::Schedule]

      # Entry site
      attribute :site, Fhir::CodeableConcept

      # Rout of administration
      attribute :route, Fhir::CodeableConcept

      # Administration method
      attribute :method, Fhir::CodeableConcept

      # Dose quantity per dose
      attribute :quantity, Fhir::Quantity

      # Dose quantity per unit of time
      attribute :rate, Fhir::Ratio

      # Total dose that should be consumed per unit of time
      attribute :max_dose_per_period, Fhir::Ratio
    end

    attribute :dosages, Array[Dosage]
  end

  attribute :dispenses, Array[Dispense]

  # Indicates whether or not substitution was made as part of
  # the dispense.  In some cases substitution will be expected
  # but doesn't happen, in other cases substitution is not
  # expected but does happen.  This block explains what
  # substitition did or did not happen and why.
  class Substitution < Fhir::ValueObject
    invariants do
      validates_presence_of :type
    end

    # Type of substitiution
    # Should be present
    attribute :type, Fhir::CodeableConcept

    # Why was substitution made
    attribute :reasons, Array[Fhir::CodeableConcept]

    # Who is responsible for the substitution
    resource_references :responsible_parties, [Fhir::Practitioner]
  end

  attribute :substitution, Substitution
end

