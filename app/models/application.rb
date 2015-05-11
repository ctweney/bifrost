class Application < ActiveRecord::Base

  belongs_to :disposition
  belongs_to :maturity
  belongs_to :owner, :class_name => Person, :foreign_key => 'owner_id', :inverse_of => :owned_applications
  belongs_to :admin, :class_name => Person, :foreign_key => 'admin_id', :inverse_of => :administered_applications
  belongs_to :technical, :class_name => Person, :foreign_key => 'technical_id', :inverse_of => :technical_applications
  belongs_to :testing, :class_name => Person, :foreign_key => 'testing_id', :inverse_of => :testing_applications

  has_and_belongs_to_many :business_processes, :join_table => 'business_process_app', :foreign_key => 'application_id'

  has_many :edos, :foreign_key => 'sor_id'
  has_many :interfaces

  rails_admin do
    list do
      field :application_id do
        column_width 20
        read_only true
        label 'ID:'
        help false
      end
      field :name do
        column_width 50
        help false
      end
      field :description do
        column_width 100
        help false
      end
      field :owner do
        column_width 50
        help false
      end
      field :go_live do
        column_width 20
        help false
      end
      field :cs_module do
        column_width 20
        help false
      end
    end
  end

end
