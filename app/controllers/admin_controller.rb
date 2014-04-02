class AdminController < ApplicationController

	def logout
    reset_session
    redirect_to :signin
  end

	def index
    #if not(current_user.try("roles") and current_user.role? :admin)
    #  reset_session
    #  redirect_to :signin
    #else
      @users = User.all.length
      @parts = Participation.all.length
    #end
	end

end
