class Program < ActiveRecord::Base
  has_many :user_program
  has_many :user, through: :user_program

  def self.id
    self.ids[0]
  end
 
  def self.is_for_admin?
    Program.where("id = ?", self.id).pluck(:admin)
  end
end
# p = Program.where(:id=>10)