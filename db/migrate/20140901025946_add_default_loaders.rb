class AddDefaultLoaders < ActiveRecord::Migration
  def up
  	Course.load
  	Holiday.load
  end

  def down
  	Course.destroy_all
  	Holiday.destroy_all
  end

end
