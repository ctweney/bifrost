class ActionType < ActiveRecord::Base

  rails_admin do
    fields do
      help false
    end
    configure :action_type_id do
      read_only true
      label 'ID:'
    end
  end

end