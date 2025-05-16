# Describes the base form object for all forms in the application.
# It includes ActiveModel::Model to provide model-like behavior for form objects.
# This allows the form objects to be used in a similar way to ActiveRecord models,
# including validations, error handling, and other features.
#
# @abstract
# @see Forecasts::ForecastAddressForm
class FormBase
  include ActiveModel::Model
end
