class BookPolicy < ApplicationPolicy
  def search? 
    user.present?
  end
  
  def trend?
    user.present?
  end
end
