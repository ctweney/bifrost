class DataType < ActiveRecord::Base

  has_many :data_fields

  rails_admin do
    fields do
      help false
    end
    configure :data_type_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
