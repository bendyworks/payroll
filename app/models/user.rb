class User < ActiveRecord::Base
  # Other available devise modules:
  #  :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :registerable, :validatable, :invitable
end
