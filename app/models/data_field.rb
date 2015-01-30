class DataField < ActiveRecord::Base

  belongs_to :data_type
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'
  has_and_belongs_to_many :edos, :join_table => 'data_edo', :foreign_key => 'data_field_id'

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