RailsAdmin.config do |config|

  config.authenticate_with do
    warden.authenticate! scope: :person
  end
  config.current_user_method(&:current_person)

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

end
