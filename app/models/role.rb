class Role < ActiveRecord::Base

  has_and_belongs_to_many :persons, :join_table => 'person_role', :foreign_key => 'role_id'

  rails_admin do
    fields do
      help false
    end
    configure :role_id do
      read_only true
      label 'ID:'
    end
  end

end
