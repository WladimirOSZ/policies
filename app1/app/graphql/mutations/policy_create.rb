# frozen_string_literal: true

module Mutations
  require_relative '../../services/bunny_sender'

  class PolicyCreate < BaseMutation
    argument :policy_id, ID, required: true
    argument :emission_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :end_coverage_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :insured_name, String, required: true
    argument :insured_cpf, String, required: true
    argument :vehicle_brand, String, required: true
    argument :vehicle_model, String, required: true
    argument :vehicle_year, String, required: true
    argument :vehicle_license_plate, String, required: true

    field :status, String, null: false
    
    def resolve(policy_id:, emission_date:, end_coverage_date:, insured_name:, insured_cpf:, vehicle_brand:, vehicle_model:, vehicle_year:, vehicle_license_plate:)
      data = {
        policy_id: policy_id,
        issue_date: emission_date,
        coverage_end_date: end_coverage_date,
        insured: {
          name: insured_name,
          cpf: insured_cpf
        },
        vehicle: {
          brand: vehicle_brand,
          model: vehicle_model,
          year: vehicle_year,
          license_plate: vehicle_license_plate
        }
      }


      BunnySender.new.publish(data: data.to_json, queue: 'policies')

      { status: 'Policy was requested.' }

    rescue StandardError => e
      { status: e.message }
    end
  end
end
