# frozen_string_literal: true

module Types
  class PoliciesType < Types::BaseObject
    field :id, ID, null: false
    field :policy_id, ID, null: false
    field :issue_date, GraphQL::Types::ISO8601DateTime, null: false
    field :coverage_end_date, GraphQL::Types::ISO8601DateTime, null: false
    field :insured_id, ID, null: false
    field :insured_name, String, null: false
    field :insured_cpf, String, null: false
    field :vehicle_id, ID, null: false
    field :vehicle_brand, String, null: false
    field :vehicle_model, String, null: false
    field :vehicle_year, String, null: false
    field :vehicle_license_plate, String, null: false
  end
end
