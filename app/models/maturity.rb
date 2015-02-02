class Maturity < ActiveRecord::Base

  has_many :applications

  rails_admin do
    fields do
      help false
    end
    configure :maturity_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
