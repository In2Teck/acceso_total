class CreateMailUsers < ActiveRecord::Migration
  def change
    create_table :mail_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
