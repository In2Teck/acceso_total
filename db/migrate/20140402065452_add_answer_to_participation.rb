class AddAnswerToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :answer, :text
  end
end
