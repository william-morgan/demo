class CreateUserPrograms < ActiveRecord::Migration
  def change
    create_table  "user_programs" do |t|
      t.integer         :program_id      , index: true
      t.boolean         :display         , :default => 1
      t.integer         :order           , :default => 0
      t.integer         :user_id         , index: true
      t.string          :token           , :default => nil
      t.timestamps null: false
    end
  end
end
