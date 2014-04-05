class ParticipationsController < ApplicationController

  load_and_authorize_resource

  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.find_by_sql("SELECT users.email, participations.id, participations.user_id, participations.created_at as fecha, participations.answer as respuesta, bottles.code as codigo, questions.name as pregunta, participations.created_at FROM participations LEFT OUTER JOIN users ON participations.user_id = users.id LEFT OUTER JOIN bottles ON participations.bottle_id = bottles.id LEFT OUTER JOIN questions ON participations.question_id = questions.id ORDER BY #{sort_column} #{sort_direction}").paginate(:page => params[:page])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @participations }
    end
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
    @participation = Participation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /participations/new
  # GET /participations/new.json
  def new
    @participation = Participation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participation }
    end
  end

  # GET /participations/1/edit
  def edit
    @participation = Participation.find(params[:id])
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(params[:participation])

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
        format.json { render json: @participation, status: :created, location: @participation }
      else
        format.html { render action: "new" }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participations/1
  # PUT /participations/1.json
  def update
    @participation = Participation.find(params[:id])

    respond_to do |format|
      if @participation.update_attributes(params[:participation])
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy

    respond_to do |format|
      format.html { redirect_to participations_url }
      format.json { head :no_content }
    end
  end
end
