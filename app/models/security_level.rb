class SecurityLevel < ActiveRecord::Base

  has_many :edos

  rails_admin do
    fields do
      help false
    end
    configure :security_level_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
