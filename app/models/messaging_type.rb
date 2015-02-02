class MessagingType < ActiveRecord::Base

  has_many :interfaces, :inverse_of => :messaging_type

  rails_admin do
    fields do
      help false
    end
    configure :messaging_type_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
