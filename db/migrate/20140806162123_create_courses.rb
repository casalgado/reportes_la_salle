class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :program
      t.string     :name
      t.integer    :semester
      t.integer    :duration
      t.integer    :credits
      t.string     :area

      t.timestamps
    end
  end
end
