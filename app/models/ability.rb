class Ability
  include CanCan::Ability

  # Admin & Editor roles are set up in seeds.rb by rake db:seed task. The system will not function properly if
  # these roles are not present in the database.
  ADMIN_ROLE_ID = 1
  EDITOR_ROLE_ID = 2

  def initialize(user)
    if user
      can :access, :all
      can :dashboard, :all
      can :read, :all
      if user.roles.exists? ADMIN_ROLE_ID
        can :manage, :all
      elsif user.roles.exists? EDITOR_ROLE_ID
        can :manage, [ActionType, Application, BusinessProcess, Criticality, DataCombination,
                      DataField, DataMapping, DataType, Disposition, Edo, Integration, Interface,
                      Maturity, Message, MessageData, MessageFormat, MessagingType, Organization,
                      ProjectAction, SecurityLevel, TransferMethod, WebServiceType]
      end
    end
  end
end
