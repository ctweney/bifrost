class Edo < ActiveRecord::Base

  belongs_to :system_of_record, :class_name => Application, :foreign_key => 'sor_id'
  belongs_to :last_action, :class_name => ProjectAction, :foreign_key => 'last_action_id'
  belongs_to :security_level
  has_and_belongs_to_many :data_fields, :join_table => 'data_edo', :foreign_key => 'edo_id'

  rails_admin do
    fields do
      help false
    end
    configure :edo_id do
      read_only true
      label 'ID:'
    end
  end

end
