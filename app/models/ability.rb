class Ability
  include CanCan::Ability

  def initialize(user)
	  user ||= User.new # guest user
    if user.role? :admin
      #can :manage, :all
	  else
      can :manage, :all
		  #can :read, :all
      #can :find_or_create_user, User
      #can :validate_bottle, Bottle
	  end
  end
end
