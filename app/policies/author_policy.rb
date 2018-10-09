class AuthorPolicy < ApplicationPolicy
  def search? 
    user.present?
  end

  def trend?
    user.present?
  end

  def import?
    user.present? && user.role == 'Admin'
  end
end
