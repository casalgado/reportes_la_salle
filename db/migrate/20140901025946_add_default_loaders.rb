class AddDefaultLoaders < ActiveRecord::Migration
  def up
  	Course.load
  	Holiday.load
  	Program.load
  end

  def down
  	Course.destroy_all
  	Holiday.destroy_all
  	Program.destroy_all
  end

end
