require_relative "adyen/version"
require_relative "adyen/client"
require_relative "adyen/errors"
require_relative "adyen/services/checkout"
require_relative "adyen/services/checkout_utility"
require_relative "adyen/services/payments"
require_relative "adyen/services/payouts"
require_relative "adyen/services/recurring"
require_relative "adyen/services/marketpay"
require_relative "adyen/services/postfmapi"
require_relative "adyen/services/service"
require_relative "adyen/hash_with_accessors"
require_relative "adyen/utils/hmac_validator"

# add snake case to camel case converter to String
# to convert rubinic method names to Adyen API methods
#
# i.e. snake_case -> snakeCase
# note that the first letter is not capitalized as normal
class String
  def to_camel_case
    split("_").collect.with_index{ |x, i| i > 0 ? x.capitalize : x }.join
  end
end
