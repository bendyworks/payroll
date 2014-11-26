class User < ActiveRecord::Base
  # Other available devise modules:
  #  :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :registerable
end
