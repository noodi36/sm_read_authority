class PostPolicy < ApplicationPolicy
  class Scope<Scope
    def resolve
      scope
    end
  end
  
  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    user.authority?(post)
  end
end
