class MessageFormat < ActiveRecord::Base

  has_many :messages, :inverse_of => :message_format

  rails_admin do
    fields do
      help false
    end
    configure :message_format_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
