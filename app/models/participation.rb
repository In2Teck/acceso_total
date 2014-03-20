class Participation < ActiveRecord::Base
  attr_accessible :bottle_id, :question_id, :user_id

  belongs_to :bottle
  belongs_to :question
  belongs_to :user
end
