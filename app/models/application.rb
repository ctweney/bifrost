class Application < ActiveRecord::Base

  belongs_to :disposition
  belongs_to :maturity
  belongs_to :owner, :class_name => Person, :foreign_key => 'owner_id', :inverse_of => :owned_applications
  belongs_to :admin, :class_name => Person, :foreign_key => 'admin_id', :inverse_of => :administered_applications
  belongs_to :technical, :class_name => Person, :foreign_key => 'technical_id', :inverse_of => :technical_applications
  belongs_to :testing, :class_name => Person, :foreign_key => 'testing_id', :inverse_of => :testing_applications

  rails_admin do
    fields do
      help false
    end
    configure :application_id do
      read_only true
      label 'ID:'
    end
  end

end
