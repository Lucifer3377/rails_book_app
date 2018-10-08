class ReviewPolicy < ApplicationPolicy
  def trend?
    true
  end

  def create?
    true
  end
end
