class Person < ActiveRecord::Base

  devise :omniauthable, :omniauth_providers => [:cas]

  def self.from_omniauth(auth)
    Person.where(calnet_uid: auth.uid).first
  end

end

