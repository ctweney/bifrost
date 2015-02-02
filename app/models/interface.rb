class Interface < ActiveRecord::Base

  belongs_to :application
  belongs_to :disposition
  belongs_to :outbound_message, :class_name => Message, :foreign_key => 'outbound_message_id', :inverse_of => :outbound_interfaces
  belongs_to :inbound_message, :class_name => Message, :foreign_key => 'inbound_message_id', :inverse_of => :inbound_interfaces
  belongs_to :transfer_method, :inverse_of => :interfaces
  belongs_to :web_service_type, :inverse_of => :interfaces
  belongs_to :messaging_type, :inverse_of => :interfaces
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'

  has_many :sourced_integrations, :class_name => Integration, :foreign_key => 'source_interface_id'
  has_many :targeted_integrations, :class_name => Integration, :foreign_key => 'target_interface_id'

  rails_admin do
    fields do
      help false
    end
    configure :interface_id do
      read_only true
      label 'ID:'
    end
  end

end
