class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :bottle_id
      t.integer :question_id
      t.text	:answer
      t.timestamps
    end
    add_index :participations, :bottle_id, :unique => true
  end
end
