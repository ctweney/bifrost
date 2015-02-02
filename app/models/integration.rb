class Integration < ActiveRecord::Base

  belongs_to :source_interface, :class_name => Interface, :foreign_key => 'source_interface_id', :inverse_of => :sourced_integrations
  belongs_to :target_interface, :class_name => Interface, :foreign_key => 'target_interface_id', :inverse_of => :targeted_integrations
  belongs_to :owner, :class_name => Person, :foreign_key => 'owner_id', :inverse_of => :owned_integrations
  belongs_to :criticality, :inverse_of => :integrations
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'

  rails_admin do
    fields do
      help false
    end
    configure :integration_id do
      read_only true
      label 'ID:'
    end
  end

end
