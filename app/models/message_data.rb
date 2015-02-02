class MessageData < ActiveRecord::Base

  rails_admin do
    fields do
      help false
    end
    configure :message_data_id do
      read_only true
      label 'ID:'
    end
  end

end
