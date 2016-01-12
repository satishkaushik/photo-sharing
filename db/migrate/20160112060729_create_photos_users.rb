class CreatePhotosUsers < ActiveRecord::Migration
  def change
    create_table :photos_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.boolean :liked
      t.text :comment
      t.boolean :is_owner

      t.timestamps null: false
    end
  end
end
