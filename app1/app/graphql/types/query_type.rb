# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # with this it worked
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"

    # def test_field
    #   "Hello World!"
    # end


    field :get_policies, Types::PoliciesType, null: true, description: "Receiveing by id" do
      argument :policy_id, ID, required: true, description: "Policy id"
    end

    def get_policies(policy_id:)
      response = HTTParty.get("http://app2:3002/policies/#{policy_id}")
      json_response = JSON.parse(response.body)
      {
        policy_id: json_response["policy_id"],
        issue_date: json_response["issue_date"],
        coverage_end_date: json_response["coverage_end_date"],
        insured_id: json_response["insured"]["id"],
        insured_name: json_response["insured"]["name"],
        insured_cpf: json_response["vehicle"]["cpf"],
        vehicle_id: json_response["vehicle"]["id"],
        vehicle_brand: json_response["vehicle"]["brand"],
        vehicle_model: json_response["vehicle"]["model"],
        vehicle_year: json_response["vehicle"]["year"],
        vehicle_license_plate: json_response["vehicle"]["license_plate"]
      }
    end
  end
end
