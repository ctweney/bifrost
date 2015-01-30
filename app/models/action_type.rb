class ActionType < ActiveRecord::Base

  has_many :project_actions

  rails_admin do
    fields do
      help false
    end
    configure :project_actions do
      read_only true
    end
    configure :action_type_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
