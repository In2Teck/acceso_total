class Ability
  include CanCan::Ability

  def initialize(user)
	  user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
	  else
		  can :read, :all
		  can :manage, :display
      can [:find_or_create_user, :get_participations], User
      can :validate_bottle, Bottle
      can :create, Participation 
      cannot :manage, :admin
	  end
  end
end
