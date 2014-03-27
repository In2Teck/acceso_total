class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		@user = User.find_for_facebook_oauth(auth_hash, current_user)
		if @user.persisted?
			sign_in @user
			render :partial => 'display/registra_codigo', :content_type => 'text/html'
      #redirect_to :registra_codigo
		else
			session["devise.facebook_data"] = auth_hash.except("extra")
			redirect_to signup_url(@user)
		end
	end

	def auth_hash
		request.env["omniauth.auth"]
	end
end
