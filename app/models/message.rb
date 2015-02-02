class Message < ActiveRecord::Base

  belongs_to :message_format, :inverse_of => :messages
  belongs_to :disposition, :inverse_of => :messages
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'

  has_and_belongs_to_many :data_fields, :join_table => 'message_data', :foreign_key => 'message_id'
  has_and_belongs_to_many :edos, :join_table => 'message_edo', :foreign_key => 'message_id'

  has_many :outbound_interfaces, :class_name => Interface, :foreign_key => 'outbound_message_id', :inverse_of => :outbound_message
  has_many :inbound_interfaces, :class_name => Interface, :foreign_key => 'inbound_message_id', :inverse_of => :inbound_message

  rails_admin do
    fields do
      help false
    end
    configure :message_id do
      read_only true
      label 'ID:'
    end
  end

end
