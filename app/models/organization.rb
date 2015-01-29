class Organization < ActiveRecord::Base

  has_many :people, :foreign_key => 'organization_id'

  rails_admin do
    fields do
      help false
    end
    configure :people do
      read_only true
    end
    configure :organization_id do
      read_only true
      label 'ID:'
    end
  end

end
