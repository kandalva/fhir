# A reference to a code defined by a terminology system.
class Fhir::Coding < Fhir::Type
  # Identity of the terminology system
  attribute :system, Fhir::URI

  # Symbol in syntax defined by the system
  attribute :code, Fhir::Code

  # Representation defined by the system
  attribute :display, String
end

