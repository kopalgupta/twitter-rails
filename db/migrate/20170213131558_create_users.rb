class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :handle, null: false 
      # added contraints in the migration file before migrating

      t.timestamps null: false
    end
  end
end
