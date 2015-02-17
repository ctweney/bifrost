class AddCsMod < ActiveRecord::Migration
  def change
    add_column(:application, :cs_module, :string)
    add_column(:interface, :cs_module, :string)
  end
end
