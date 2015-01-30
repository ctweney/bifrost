class Organization < ActiveRecord::Base

  has_many :people, :foreign_key => 'organization_id'
  has_many :business_processes, :foreign_key => 'functional_org_id'

  rails_admin do
    fields do
      help false
    end
    configure :people do
      read_only true
    end
    configure :business_processes do
      read_only true
    end
    configure :organization_id do
      read_only true
      label 'ID:'
    end
  end

end
