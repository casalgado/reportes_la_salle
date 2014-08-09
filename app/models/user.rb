class User < ActiveRecord::Base
  
  has_many :lectures
  has_many :courses, through:  :lectures

  has_many :reports

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { minimum: 4}
  validates :last_name , presence: true, length: { minimum: 4}

end
