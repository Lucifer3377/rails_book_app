class ReviewPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
