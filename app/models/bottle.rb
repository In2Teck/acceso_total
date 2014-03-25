class Bottle < ActiveRecord::Base
  attr_accessible :code

  has_one :participation

  def self.validate_code code
    return Bottle.find_by_code(code)
  end

end
