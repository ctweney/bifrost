class Criticality < ActiveRecord::Base

  rails_admin do
    fields do
      help false
    end
    configure :criticality_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    description
  end

end
