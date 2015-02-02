class Disposition < ActiveRecord::Base

  has_many :applications, :inverse_of => :disposition
  has_many :interfaces, :inverse_of => :disposition
  has_many :messages, :inverse_of => :disposition

  rails_admin do
    fields do
      help false
    end
    configure :disposition_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
