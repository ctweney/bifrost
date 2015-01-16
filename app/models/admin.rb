class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:cas]

  def self.from_omniauth(auth)
    Admin.where(provider: auth.provider, uid: auth.uid).first
  end
end

