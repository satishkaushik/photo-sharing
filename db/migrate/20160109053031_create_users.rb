class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| 
      t.column :username, :string
      t.column :email, :string
      
      t.timestamps null: false
  	end
  end
end
