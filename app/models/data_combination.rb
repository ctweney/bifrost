class DataCombination < ActiveRecord::Base

  rails_admin do
    fields do
      help false
    end
    configure :data_combination_id do
      read_only true
      label 'ID:'
    end
  end

  def name
    combination_logic
  end

end
