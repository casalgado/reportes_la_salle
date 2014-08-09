class Report < ActiveRecord::Base

	belongs_to :user

	validates_uniqueness_of :user_id, :scope => [:year, :month_of_report]

end
