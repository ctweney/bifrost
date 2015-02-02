class DataField < ActiveRecord::Base

  belongs_to :data_type
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'

  has_and_belongs_to_many :edos, :join_table => 'data_edo', :foreign_key => 'data_field_id'
  has_and_belongs_to_many :messages, :join_table => 'message_data', :foreign_key => 'data_field_id'
  has_and_belongs_to_many :data_combinations, :join_table => 'field_combination', :foreign_key => 'data_field_id'

  has_many :data_mappings_sourced, :class_name => DataMapping, :foreign_key => 'source_field_id', :inverse_of => :source_field
  has_many :data_mappings_resulted, :class_name => DataMapping, :foreign_key => 'result_field_id', :inverse_of => :result_field

  rails_admin do
    fields do
      help false
    end
    configure :data_field_id do
      read_only true
      label 'ID:'
    end
  end

end