class AddBelongsToLecturedays < ActiveRecord::Migration
  def change
    add_column :lecture_days, :report_id, :integer
    add_index  :lecture_days, :report_id
  end
end
