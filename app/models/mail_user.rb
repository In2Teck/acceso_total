class MailUser < ActiveRecord::Base
  attr_accessible :email, :name
end
