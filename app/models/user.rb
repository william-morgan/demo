class User < ActiveRecord::Base
  has_many :user_program
  has_many :program, through: :user_program
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable,
         :omniauthable
  include DeviseTokenAuth::Concerns::User
  after_create  :default_user_programs
  after_destroy { |user| destroy_user_programs(user.id) }

  def default_user_programs    
    user_program                  = {}
    user_program[:user_id]        = User.pluck(:id).last
    user_program[:token]          = User.where(:id=>user_program[:user_id]).pluck(:tokens)[0].keys[0]
    user_program[:created_at]     = DateTime.now #important for user_programs_controller.rb last_known_save
    user_program[:updated_at]     = DateTime.now #important for user_programs_controller.rb last_known_save
    this_user                     = User.where(:id=>user_program[:user_id])
    programs                      = Program.select(:id, :admin, :default_status)

    programs.each do |program|
      display   = program.default_status == true ? 1:0
      user_program[:display]      = display                 #default
      user_program[:order]        = program.id              #default
      user_program[:program_id]   = program.id
      program_is_admin            = program.admin           #diction

      if program_is_admin and this_user.is_admin?
        UserProgram.create(user_program)
      elsif  program_is_admin and this_user.is_not_admin?
        next
      else
        UserProgram.create(user_program)                
      end
    end
  end

  def destroy_user_programs(id)
    UserProgram.where(:user_id=>id).destroy_all
  end

  #override devise
  def send_on_create_confirmation_instructions
  end

  def self.id
    self.ids[0]
  end

  def self.is_admin?
    User.where("id = ?", self.id).pluck(:admin)
  end

  def self.is_not_admin?
    !User.where("id = ?", self.id).pluck(:admin)
  end
  protected
end
