class Person < ActiveRecord::Base

  devise :omniauthable, :omniauth_providers => [:cas]

  belongs_to :organization

  has_many :owned_applications, :class_name => Application, :foreign_key => 'owner_id'
  has_many :administered_applications, :class_name => Application, :foreign_key => 'admin_id'
  has_many :technical_applications, :class_name => Application, :foreign_key => 'technical_id'
  has_many :testing_applications, :class_name => Application, :foreign_key => 'testing_id'
  has_many :owned_integrations, :class_name => Integration, :foreign_key => 'owner_id'
  has_many :project_actions_taken, :class_name => ProjectAction, :foreign_key => 'actor_id'

  has_and_belongs_to_many :roles, :join_table => 'person_role', :foreign_key => 'person_id'

  rails_admin do
    fields do
      help false
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

