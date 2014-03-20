class Bottle < ActiveRecord::Base
  attr_accessible :code

  has_one :participation
end
