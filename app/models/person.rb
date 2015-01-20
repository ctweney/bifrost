class Person < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:cas]

  def self.from_omniauth(auth)
    Person.where(calnetUid: auth.uid).first
  end

  def uid
    calnetUid
  end

end

