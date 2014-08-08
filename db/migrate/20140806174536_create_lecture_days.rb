class CreateLectureDays < ActiveRecord::Migration
  def change
    create_table :lecture_days do |t|
    	t.belongs_to :lecture
      t.date       :date_of_lecture
      t.time       :time_of_lecture
      t.integer    :month_of_report
      t.timestamps
    end
  end
end
