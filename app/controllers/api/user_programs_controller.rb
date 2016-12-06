class Api::UserProgramsController < ApplicationController
  respond_to :json
  def index
    user            = get_current_user
    last_known_save = UserProgram.where(:user_id => user.id)
                                 .select(:created_at)
                                 .distinct
                                 .order("created_at DESC")
                                 .first
    @programs       = UserProgram.joins(:user)
                                 .joins(:program)
                                 .where("user_programs.user_id=?", user)
                                 .where("user_programs.created_at=?", last_known_save.created_at)
                                 .where("( programs.admin = 0 AND (users.admin = 1 OR users.admin = 0)) OR (programs.admin=1 AND users.admin =1)")
                                 .select("programs.id, 
                                          programs.name,
                                          programs.name_shorthand, 
                                          programs.description, 
                                          programs.launch_text,
                                          user_programs.display")
                                 .order("user_programs.order")                   #important for customizing homepage
    render json: @programs
  end
  def create
    user_programs   = params[:user_programs]
    at_timestamp    = DateTime.now #important for user_programs_controller.rb last_known_save
    user_programs.each do |user_program|
      u             = UserProgram.new
      u.user_id     = user_program[:user_id]
      u.program_id  = user_program[:program_id]
      u.display     = user_program[:display]
      u.order       = user_program[:order]
      u.token       = user_program[:token]
      u.created_at  = at_timestamp
      u.updated_at  = at_timestamp
      if !u.save
        render json: user_program.errors, status: :unprocessable_entity
      end
    end
    render json: user_programs, status: :created 
  end
end