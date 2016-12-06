class ProgramController < ApplicationController
  def index
    auth_headers = JSON.parse(cookies[:auth_headers])

    @user        = get_current_user
    @token       = auth_headers["client"]
    @id          = User.where(:email=> auth_headers["uid"]).pluck(:id)[0]
    last_save    = UserProgram.where(:user_id => @id)
                              .select(:created_at)
                              .distinct
                              .order("created_at DESC")
                              .first
    @programs    = UserProgram.joins(:user)
                              .joins(:program)
                              .where("user_programs.user_id=?", @id)
                              .where("user_programs.created_at=?", last_save.created_at)
                              .where("user_programs.display=1")
                              .where("( programs.admin = 0 AND (users.admin = 1 OR users.admin = 0)) OR (programs.admin=1 AND users.admin =1)")
                              .select("programs.id, 
                                       programs.name,
                                       programs.name_shorthand, 
                                       programs.description, 
                                       programs.launch_text,
                                       user_programs.display")
                              .order("user_programs.order")   
  end
end