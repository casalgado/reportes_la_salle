class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :year
      t.integer :day

      t.timestamps
    end
  end
end
