class AuthorPolicy < ApplicationPolicy
  def search? 
    true
  end

  def trend?
    true
  end

  def import?
    user.role == 'Admin'
  end
end
