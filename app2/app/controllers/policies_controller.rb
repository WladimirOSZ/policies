class PoliciesController < ActionController::API
  def index
    policies = Policy.all
    render json: policies, include: %i[insured vehicle]
  end

  def show
    policy = Rails.cache.fetch("policy_#{params[:id]}", expires_in: 7.days) do
      Policy.find_by(policy_id: params[:id])
    end
  
    render json: policy, include: %i[insured vehicle]
  end
end
