# Talks Controller, does what it says on the tin
class TalksController < ApplicationController
  before_action :set_talk, only: [:show]

  # GET /talks
  # GET /talks.json
  def index
    respond_to do |format|
      format.html { @talks = Talk.all }
      format.json { render json: Talk.all }
    end
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    respond_to do |format|
      format.html { @talk }
      format.json { render json: @talk }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_talk
    @talk = Talk.find(params[:id])
  end
end
