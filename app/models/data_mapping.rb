class DataMapping < ActiveRecord::Base

  belongs_to :source_field, :class_name => DataField, :foreign_key => 'source_field_id', :inverse_of => :data_mappings_sourced
  belongs_to :source_combination, :class_name => DataCombination, :foreign_key => 'source_combination_id', :inverse_of => :data_combinations_sourced
  belongs_to :result_field, :class_name => DataField, :foreign_key => 'result_field_id', :inverse_of => :data_mappings_resulted
  belongs_to :result_combination, :class_name => DataCombination, :foreign_key => 'result_combination_id', :inverse_of => :data_combinations_resulted

  rails_admin do
    fields do
      help false
    end
    configure :data_mapping_id do
      read_only true
      label 'ID:'
    end
  end

end
