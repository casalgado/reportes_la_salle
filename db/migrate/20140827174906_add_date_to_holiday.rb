class AddDateToHoliday < ActiveRecord::Migration
  def change
    add_column :holidays, :date, :date
  end
end
