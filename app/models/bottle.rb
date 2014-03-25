class Bottle < ActiveRecord::Base
  attr_accessible :code

  has_one :participation

  def self.valid_code code
    if Bottle.find_by_code(code)
      return true
    else
      return false
    end
  end

end
