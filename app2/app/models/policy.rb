class Policy < ApplicationRecord
  has_one :insured
  has_one :vehicle
end
