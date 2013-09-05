# A series of measurements taken by a device, with upper and
# lower limits. There may be more than one dimension in the
# data.
class Fhir::SampledData < Fhir::DataType
  # Zero value and units
  attribute :origin, Fhir::Quantity

  # Number of milliseconds between samples
  attribute :period, Float

  # Multiply data by this before adding to origin
  attribute :factor, Float

  # Lower limit of detection
  attribute :lower_limit, Float

  # Upper limit of detection
  attribute :upper_limit, Float

  # Number of sample points at each time point
  attribute :dimensions, Integer

  # Decimal values with spaces, or "E" | "U" | "L"
  attribute :data, String
end

