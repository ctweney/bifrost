class ChangeBusinessProcessColumnTypes < ActiveRecord::Migration
  def change
    change_column :business_process, :description, :text
  end
end
