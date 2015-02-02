class WebServiceType < ActiveRecord::Base

  has_many :interfaces, :inverse_of => :web_service_type

  rails_admin do
    fields do
      help false
    end
    configure :web_service_type_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
