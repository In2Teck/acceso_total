class Bottle < ActiveRecord::Base
  attr_accessible :code

  has_one :participation

  def self.validate_code code
    if b = Bottle.find_by_code(code)
      if Participation.find_by_bottle_id(b.id)
        return nil 
      else
        return b
      end
    else
      return nil 
    end
  end

end
