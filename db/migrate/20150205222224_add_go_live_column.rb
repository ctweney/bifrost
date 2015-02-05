class AddGoLiveColumn < ActiveRecord::Migration
  def change
    add_column(:application, :go_live, :string)
  end
end
