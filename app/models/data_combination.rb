class DataCombination < ActiveRecord::Base

  has_many :data_combinations_sourced, :class_name => DataMapping, :foreign_key => 'source_combination_id', :inverse_of => :source_combination
  has_many :data_combinations_resulted, :class_name => DataMapping, :foreign_key => 'result_combination_id', :inverse_of => :result_combination

  has_and_belongs_to_many :data_fields, :join_table => 'field_combination', :foreign_key => 'data_combination_id'

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
