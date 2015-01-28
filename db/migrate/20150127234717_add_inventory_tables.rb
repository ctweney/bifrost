class AddInventoryTables < ActiveRecord::Migration
  def change

    # TODO what's the proper value for size? (used as maxlength in a couple of cols)
    size = 255

    create_table :action_type, :id => false do |t|
      t.integer :action_type_id, :null => false
      t.string :description
    end
    add_index(:action_type, [:action_type_id], :unique => true, :name => :action_type_id_unq_idx)

    create_table :business_process_app, :id => false do |t|
      t.integer :business_process_app_id, :null => false
      t.references :application
      t.references :business_process
    end
    add_index(:business_process_app, [:business_process_app_id], :unique => true, :name => :business_process_app_id_unq_idx)
    add_index(:business_process_app, [:application_id], :name => :business_process_app_application_id_idx)
    add_index(:business_process_app, [:business_process_id], :name => :business_process_id_idx)

    create_table :criticality, :id => false do |t|
      t.integer :criticality_id, :null => false
      t.string :description
    end
    add_index(:criticality, [:criticality_id], :unique => true, :name => :criticality_id_unq_idx)

    create_table :data_combination, :id => false do |t|
      t.integer :data_combination_id, :null => false
      t.text :combination_logic
    end
    add_index(:data_combination, [:data_combination_id], :unique => true, :name => :data_combination_id_unq_idx)

    create_table :data_mapping, :id => false do |t|
      t.integer :data_mapping_id, :null => false
      t.integer :source_field_id # t.references :data_field
      t.integer :source_combination_id # t.references :data_combination
      t.integer :result_field_id # t.references :data_field
      t.integer :result_combination_id # t.references :data_combination
      t.text :transformation
    end
    add_index(:data_mapping, [:data_mapping_id], :unique => true, :name => :data_mapping_id_unq_idx)
    add_index(:data_mapping, [:source_field_id], :name => :source_field_id_idx)
    add_index(:data_mapping, [:source_combination_id], :name => :source_combination_id_idx)
    add_index(:data_mapping, [:result_field_id], :name => :result_field_id_idx)
    add_index(:data_mapping, [:result_combination_id], :name => :result_combination_id_idx)

    create_table :data_type, :id => false do |t|
      t.integer :data_type_id, :null => false
      t.string :description
    end
    add_index(:data_type, [:data_type_id], :unique => true, :name => :data_type_id_unq_idx)

    create_table :disposition, :id => false do |t|
      t.integer :disposition_id, :null => false
      t.string :description
    end
    add_index(:disposition, [:disposition_id], :unique => true, :name => :disposition_id_unq_idx)

    create_table :field_combination, :id => false do |t|
      t.integer :field_combination_id, :null => false
      t.references :data_combination
      t.references :data_field
    end
    add_index(:field_combination, [:field_combination_id], :unique => true, :name => :field_combination_id_unq_idx)
    add_index(:field_combination, [:data_combination_id], :name => :data_combination_id_idx)
    add_index(:field_combination, [:data_field_id], :name => :field_combination_data_field_id_idx)

    create_table :data_edo, :id => false do |t|
      t.integer :data_edo_id, :null => false
      t.references :data_field
      t.references :edo
      t.string :cardinality
    end
    add_index(:data_edo, [:data_edo_id], :unique => true, :name => :data_edo_id_unq_idx)
    add_index(:data_edo, [:data_field_id], :name => :data_edo_data_field_id_idx)
    add_index(:data_edo, [:edo_id], :name => :data_edo_edo_id_idx)

    create_table :maturity, :id => false do |t|
      t.integer :maturity_id, :null => false
      t.string :description
    end
    add_index(:maturity, [:maturity_id], :unique => true, :name => :maturity_id_unq_idx)

    create_table :message_data, :id => false do |t|
      t.integer :message_data_id, :null => false
      t.references :message
      t.references :data_field
      t.string :cardinality
    end
    add_index(:message_data, [:message_data_id], :unique => true, :name => :message_data_id_unq_idx)
    add_index(:message_data, [:message_id], :name => :message_data_message_id_idx)
    add_index(:message_data, [:data_field_id], :name => :message_data_data_field_id_idx)

    create_table :message_edo, :id => false do |t|
      t.integer :message_edo_id, :null => false
      t.references :message
      t.references :edo
      t.string :cardinality
    end
    add_index(:message_edo, [:message_edo_id], :unique => true, :name => :message_edo_id_unq_idx)
    add_index(:message_edo, [:message_id], :name => :message_edo_message_id_idx)
    add_index(:message_edo, [:edo_id], :name => :message_edo_edo_id_idx)

    create_table :message_format, :id => false do |t|
      t.integer :message_format_id, :null => false
      t.string :description
    end
    add_index(:message_format, [:message_format_id], :unique => true, :name => :message_format_id_unq_idx)

    create_table :messaging_type, :id => false do |t|
      t.integer :messaging_type_id, :null => false
      t.string :description
    end
    add_index(:messaging_type, [:messaging_type_id], :unique => true, :name => :messaging_type_id_unq_idx)

    create_table :organization, :id => false do |t|
      t.integer :organization_id, :null => false
      t.string :name
      t.text :description
    end
    add_index(:organization, [:organization_id], :unique => true, :name => :organization_id_unq_idx)

    create_table :person, :id => false do |t|
      t.integer :person_id, :null => false
      t.references :organization
      t.integer :calnet_uid
      t.string :name
      t.string :position
      t.string :email
      t.string :phone
    end
    add_index(:person, [:person_id], :unique => true, :name => :person_id_unq_idx)
    add_index(:person, [:organization_id], :name => :organization_id_idx)
    add_index(:person, [:calnet_uid], :name => :calnet_uid_idx)

    create_table :business_process, :id => false do |t|
      t.integer :business_process_id, :null => false
      t.string :name, :limit => size
      t.string :description, :limit => size
      t.integer :functional_org_id # t.references :organization
    end
    add_index(:business_process, [:business_process_id], :unique => true, :name => :business_process_id_unq_idx)
    add_index(:business_process, [:functional_org_id], :name => :functional_org_id_idx)

    create_table :application, :id => false do |t|
      t.integer :application_id, :null => false
      t.string :name
      t.text :description
      t.references :disposition
      t.references :maturity
      t.integer :owner_id # t.references :person
      t.integer :admin_id # t.references :person
      t.integer :technical_id # t.references :person
      t.integer :testing_id # t.references :person
      t.boolean :legacy_flag
    end
    add_index(:application, [:application_id], :unique => true, :name => :application_id_unq_idx)
    add_index(:application, [:disposition_id], :name => :application_disposition_id_idx)
    add_index(:application, [:maturity_id], :name => :maturity_id_idx)
    add_index(:application, [:owner_id], :name => :application_owner_id_idx)
    add_index(:application, [:admin_id], :name => :admin_id_idx)
    add_index(:application, [:technical_id], :name => :technical_id_idx)
    add_index(:application, [:testing_id], :name => :testing_id_idx)

    create_table :project_action, :id => false do |t|
      t.integer :project_action_id, :null => false
      t.string :entity
      t.references :action_type
      t.integer :actor_id # t.references :person
      t.date :date
      t.text :description
    end
    add_index(:project_action, [:project_action_id], :unique => true, :name => :project_action_id_unq_idx)
    add_index(:project_action, [:entity], :name => :entity_idx)
    add_index(:project_action, [:action_type_id], :name => :action_type_id_idx)
    add_index(:project_action, [:actor_id], :name => :actor_id_idx)

    create_table :role, :id => false do |t|
      t.integer :role_id, :null => false
      t.string :name
      t.text :description
    end
    add_index(:role, [:role_id], :unique => true, :name => :role_id_unq_idx)

    create_table :integration, :id => false do |t|
      t.integer :integration_id, :null => false
      t.integer :source_interface_id # t.references :interface
      t.integer :target_interface_id # t.references :interface
      t.integer :owner_id # t.references :person
      t.string :name
      t.text :description
      t.text :security
      t.references :criticality
      t.string :version
      t.string :legacy_source
      t.string :legacy_target
      t.text :legacy_notes
      t.string :reference_uri
      t.string :jira_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:integration, [:integration_id], :unique => true, :name => :integration_id_unq_idx)
    add_index(:integration, [:source_interface_id], :name => :source_interface_id_idx)
    add_index(:integration, [:target_interface_id], :name => :target_interface_id_idx)
    add_index(:integration, [:owner_id], :name => :integration_owner_id_idx)
    add_index(:integration, [:criticality_id], :name => :criticality_id_idx)
    add_index(:integration, [:last_action_id], :name => :integration_last_action_id_idx)

    create_table :data_field, :id => false do |t|
      t.integer :data_field_id, :null => false
      t.string :name
      t.text :description
      t.references :data_type
      t.string :length
      t.boolean :nullable
      t.string :default
      t.text :validation
      t.text :notes
      t.boolean :legacy_flag
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:data_field, [:data_field_id], :unique => true, :name => :data_field_id_unq_idx)
    add_index(:data_field, [:data_type_id], :name => :data_type_id_idx)
    add_index(:data_field, [:last_action_id], :name => :data_field_last_action_id_idx)

    create_table :message, :id => false do |t|
      t.integer :message_id, :null => false
      t.string :name
      t.text :description
      t.references :message_format
      t.string :version
      t.references :disposition
      t.string :reference_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:message, [:message_id], :unique => true, :name => :message_id_unq_idx)
    add_index(:message, [:message_format_id], :name => :message_format_id_idx)
    add_index(:message, [:disposition_id], :name => :message_disposition_id_idx)
    add_index(:message, [:last_action_id], :name => :message_last_action_id_idx)

    create_table :person_role, :id => false do |t|
      t.integer :person_role_id, :null => false
      t.references :role
      t.references :person
    end
    add_index(:person_role, [:person_role_id], :unique => true, :name => :person_role_id_unq_idx)
    add_index(:person_role, [:role_id], :name => :role_id_idx)
    add_index(:person_role, [:person_id], :name => :person_id_idx)

    create_table :security_level, :id => false do |t|
      t.integer :security_level_id, :null => false
      t.string :description
    end
    add_index(:security_level, [:security_level_id], :unique => true, :name => :security_level_id_unq_idx)

    create_table :edo, :id => false do |t|
      t.integer :edo_id, :null => false
      t.string :name
      t.text :description
      t.integer :sor_id # t.references :application
      t.references :security_level
      t.string :version
      t.string :repository_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:edo, [:edo_id], :unique => true, :name => :edo_id_unq_idx)
    add_index(:edo, [:sor_id], :name => :sor_id_idx)
    add_index(:edo, [:security_level_id], :name => :security_level_id_idx)
    add_index(:edo, [:last_action_id], :name => :edo_last_action_id_idx)

    create_table :transfer_method, :id => false do |t|
      t.integer :transfer_method_id, :null => false
      t.string :description
    end
    add_index(:transfer_method, [:transfer_method_id], :unique => true, :name => :transfer_method_id_unq_idx)

    create_table :interface, :id => false do |t|
      t.integer :interface_id, :null => false
      t.references :application
      t.string :name
      t.text :description
      t.references :disposition
      t.integer :outbound_message_id # t.references :message
      t.integer :inbound_message_id # t.references :message
      t.references :transfer_method
      t.text :batch_run_frequency
      t.text :batch_execution_method
      t.text :batch_execution_restrictions
      t.string :batch_data_source_uri
      t.string :batch_data_target_uri
      t.references :web_service_type
      t.string :web_service_uri
      t.text :web_service_operations
      t.text :web_service_errors
      t.references :messaging_type
      t.string :messaging_topic
      t.string :messaging_queue
      t.text :custom_desc
      t.string :monitoring_endpoint
      t.text :recovery_process
      t.boolean :legacy_flag
      t.string :reference_uri
      t.string :jira_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:interface, [:interface_id], :unique => true, :name => :interface_id_unq_idx)
    add_index(:interface, [:application_id], :name => :interface_application_id_idx)
    add_index(:interface, [:disposition_id], :name => :interface_disposition_id_idx)
    add_index(:interface, [:outbound_message_id], :name => :outbound_message_id_idx)
    add_index(:interface, [:inbound_message_id], :name => :inbound_message_id_idx)
    add_index(:interface, [:transfer_method_id], :name => :transfer_method_id_idx)
    add_index(:interface, [:web_service_type_id], :name => :web_service_type_id_idx)
    add_index(:interface, [:messaging_type_id], :name => :messaging_type_id_idx)
    add_index(:interface, [:last_action_id], :name => :interface_last_action_id_idx)

    create_table :web_service_type, :id => false do |t|
      t.integer :web_service_type_id, :null => false
      t.string :description
    end
    add_index(:web_service_type, [:web_service_type_id], :unique => true, :name => :web_service_type_id_unq_idx)

  end
end
