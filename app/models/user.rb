class User < ActiveRecord::Base
  
  has_many :lectures
  has_many :courses, through:  :lectures
  has_many :lecture_days, through:  :lectures

  has_many :reports

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { minimum: 4}
  validates :last_name , presence: true, length: { minimum: 4}

  # Este metodo para calcular el numero de reportes que deben ser entregados en un periodo. ReportsController/index

  def self.per_period(period)
  	Lecture.where(:period => period, :year => Date.today.year).select(:user_id).map(&:user_id)
  end

  # Estos son para hacer la lista de usuarios con reportes entregados y por entregar. ReportsController/report_list

  # Entregados

  def self.turned_in_report(month)
    User.where( { id: [Report.reports_turned_in_users(month)]})
  end

  # Por entregar

  def self.still_owe_report(month, period)
    User.where( { id: [User.per_period(period) - Report.reports_turned_in_users(month)]})
  end


end
