class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string  :name          
      t.string  :name_shorthand
      t.string  :icon          , :default => 'file'
      t.string  :color         , :default => '#970000'
      t.string  :launch_text   , :default => 'Launch App'
      t.string  :url           , :default => nil          , null: true
      t.text    :description                              , null: true
      t.boolean :admin         , :default => 0
      t.boolean :default_status, :default => 1
      
      t.timestamps null: false
    end
  end
end
