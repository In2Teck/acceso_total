class Invite < ActiveRecord::Base
  attr_accessible :invited_uid, :user_id

  belongs_to :user
end
