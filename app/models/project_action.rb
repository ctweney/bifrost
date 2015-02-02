class ProjectAction < ActiveRecord::Base

  belongs_to :action_type, :inverse_of => :project_actions
  belongs_to :actor, :class_name => Person, :foreign_key => 'actor_id', :inverse_of => :project_actions_taken

  rails_admin do
    fields do
      help false
    end
    configure :project_action_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    "#{date}: #{description}"
  end

end
