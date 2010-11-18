#ability.rb
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new  
    
    can :manage, :all if user.roles.nil? ? false : user.roles.include?("admin")
  end
end
