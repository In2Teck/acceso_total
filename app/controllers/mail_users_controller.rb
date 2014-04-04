class MailUsersController < ApplicationController
  # GET /mail_users
  # GET /mail_users.json
  def index
    @mail_users = MailUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mail_users }
    end
  end

  # GET /mail_users/1
  # GET /mail_users/1.json
  def show
    @mail_user = MailUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mail_user }
    end
  end

  # GET /mail_users/new
  # GET /mail_users/new.json
  def new
    @mail_user = MailUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mail_user }
    end
  end

  # GET /mail_users/1/edit
  def edit
    @mail_user = MailUser.find(params[:id])
  end

  # POST /mail_users
  # POST /mail_users.json
  def create
    @mail_user = MailUser.new(params[:mail_user])
	
    respond_to do |format|
      if @mail_user.save
		UserMailer.registration_confirmation(@mail_user).deliver
        format.html { redirect_to @mail_user, notice: 'Mail user was successfully created.' }
        format.json { render json: @mail_user, status: :created, location: @mail_user }
      else
        format.html { render action: "new" }
        format.json { render json: @mail_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mail_users/1
  # PUT /mail_users/1.json
  def update
    @mail_user = MailUser.find(params[:id])

    respond_to do |format|
      if @mail_user.update_attributes(params[:mail_user])
        format.html { redirect_to @mail_user, notice: 'Mail user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mail_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_users/1
  # DELETE /mail_users/1.json
  def destroy
    @mail_user = MailUser.find(params[:id])
    @mail_user.destroy

    respond_to do |format|
      format.html { redirect_to mail_users_url }
      format.json { head :no_content }
    end
  end
end
