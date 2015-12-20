class User < ActiveRecord::Base
  # Other available devise modules:
  #  :confirmable, :lockable, :timeoutable, :omniauthable
  devise(:database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :registerable,
         :validatable,
         :invitable)

  def pending?
    last_sign_in_at.nil? && invitation_accepted_at.nil?
  end
end
