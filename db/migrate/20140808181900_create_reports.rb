class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
    	t.belongs_to :user
      t.integer    :year
      t.integer    :month_of_report
      t.integer    :total_hours
      t.timestamps

      t.timestamps
    end
  end
end
