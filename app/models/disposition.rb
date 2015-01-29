class Disposition < ActiveRecord::Base

  has_many :applications

  def name
    description
  end

end
