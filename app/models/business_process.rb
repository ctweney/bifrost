class BusinessProcess < ActiveRecord::Base

  belongs_to :organization, :foreign_key => 'functional_org_id'
  has_and_belongs_to_many :applications, :join_table => 'business_process_app', :foreign_key => 'business_process_id'

  rails_admin do
    fields do
      help false
    end
    configure :business_process_id do
      read_only true
      label 'ID:'
    end
  end

end
