class Api::ProgramsController < ApplicationController
  respond_to :json
  def index
    @programs = Program.all
    render json: @programs    
  end
  def show
    @program = Program.where("id = ?", params[:id])
    render json: @program
  end
end