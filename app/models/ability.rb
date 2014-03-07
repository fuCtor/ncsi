class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Computer  do |com|
      user.has_role? :owner, com
    end

    can :manage, ComputerDecorator  do |com|
      user.has_role? :owner, com.object
    end
  end
end
