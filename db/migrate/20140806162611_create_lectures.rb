class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.integer    :year
      t.integer    :period
      t.integer    :week_day
      t.time       :lecture_start_time

      t.timestamps
    end
  end
end
