class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|

    	t.string  :name
    	t.integer :semesters

      t.timestamps
    end
  end
end
