class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.string :code

      t.timestamps
    end

    add_index :bottles, :code, :unique => true
  end
end
