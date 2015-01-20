class CreatePerson < ActiveRecord::Migration
  def change
    create_table :person do |t|
      t.string :calnetUid
      t.string :name

      t.timestamps null: false
    end
  end
end
