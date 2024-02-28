class PoliciesController < ActionController::API
  def index
    policies = Policy.all
    render json: policies, include: %i[insured vehicle]
  end

  def show
    policy = Policy.find_by(policy_id: params[:id])
    render json: policy, include: %i[insured vehicle]
  end
end
