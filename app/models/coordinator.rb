class Coordinator < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Coordinator.new(first_name:"developer", last_name:"Colombia", email:"lcireportedigital@gmail.com", password:"1Awareness", password_confirmation: "1Awareness")
end

