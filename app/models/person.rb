class Person < ActiveRecord::Base

  devise :omniauthable, :omniauth_providers => [:cas]
  has_many :owned_applications, :class_name => Application, :foreign_key => 'owner_id'
  has_many :administered_applications, :class_name => Application, :foreign_key => 'admin_id'
  has_many :technical_applications, :class_name => Application, :foreign_key => 'technical_id'
  has_many :testing_applications, :class_name => Application, :foreign_key => 'testing_id'
  belongs_to :organization

  rails_admin do
    fields do
      help false
    end
    configure :owned_applications do
      read_only true
    end
    configure :administered_applications do
      read_only true
    end
    configure :technical_applications do
      read_only true
    end
    configure :testing_applications do
      read_only true
    end
    configure :person_id do
      read_only true
      label 'ID:'
    end
  end

  def self.from_omniauth(auth)
    Person.where(calnet_uid: auth.uid).first
  end

end

