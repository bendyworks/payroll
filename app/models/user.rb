class User < ActiveRecord::Base
  # Other available devise modules:
  # :registerable, :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
end
