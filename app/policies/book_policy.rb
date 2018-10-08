class BookPolicy < ApplicationPolicy
  def search? 
    true
  end
  
  def trend?
    true
  end
end
