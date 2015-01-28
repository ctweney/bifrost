class AddInventoryTables < ActiveRecord::Migration
  def change

    # TODO what's the proper value for size? (used as maxlength in a couple of cols)
    size = 255

    create_table :action_type, :primary_key => 'action_type_id' do |t|
      t.string :description
    end

    create_table :business_process_app, :primary_key => 'business_process_app_id' do |t|
      t.references :application
      t.references :business_process
    end
    add_index(:business_process_app, [:application_id], :name => :business_process_app_application_id_idx)
    add_index(:business_process_app, [:business_process_id], :name => :business_process_id_idx)

    create_table :criticality, :primary_key => 'criticality_id' do |t|
      t.string :description
    end

    create_table :data_combination, :primary_key => 'data_combination_id' do |t|
      t.text :combination_logic
    end

    create_table :data_mapping, :primary_key => 'data_mapping_id' do |t|
      t.integer :source_field_id # t.references :data_field
      t.integer :source_combination_id # t.references :data_combination
      t.integer :result_field_id # t.references :data_field
      t.integer :result_combination_id # t.references :data_combination
      t.text :transformation
    end
    add_index(:data_mapping, [:source_field_id], :name => :source_field_id_idx)
    add_index(:data_mapping, [:source_combination_id], :name => :source_combination_id_idx)
    add_index(:data_mapping, [:result_field_id], :name => :result_field_id_idx)
    add_index(:data_mapping, [:result_combination_id], :name => :result_combination_id_idx)

    create_table :data_type, :primary_key => 'data_type_id' do |t|
      t.string :description
    end

    create_table :disposition, :primary_key => 'disposition_id' do |t|
      t.string :description
    end

    create_table :field_combination, :primary_key => 'field_combination_id' do |t|
      t.references :data_combination
      t.references :data_field
    end
    add_index(:field_combination, [:data_combination_id], :name => :data_combination_id_idx)
    add_index(:field_combination, [:data_field_id], :name => :field_combination_data_field_id_idx)

    create_table :data_edo, :primary_key => 'data_edo_id' do |t|
      t.references :data_field
      t.references :edo
      t.string :cardinality
    end
    add_index(:data_edo, [:data_field_id], :name => :data_edo_data_field_id_idx)
    add_index(:data_edo, [:edo_id], :name => :data_edo_edo_id_idx)

    create_table :maturity, :primary_key => 'maturity_id' do |t|
      t.string :description
    end

    create_table :message_data, :primary_key => 'message_data_id' do |t|
      t.references :message
      t.references :data_field
      t.string :cardinality
    end
    add_index(:message_data, [:message_id], :name => :message_data_message_id_idx)
    add_index(:message_data, [:data_field_id], :name => :message_data_data_field_id_idx)

    create_table :message_edo, :primary_key => 'message_edo_id' do |t|
      t.references :message
      t.references :edo
      t.string :cardinality
    end
    add_index(:message_edo, [:message_id], :name => :message_edo_message_id_idx)
    add_index(:message_edo, [:edo_id], :name => :message_edo_edo_id_idx)

    create_table :message_format, :primary_key => 'message_format_id' do |t|
      t.string :description
    end

    create_table :messaging_type, :primary_key => 'messaging_type_id' do |t|
      t.string :description
    end

    create_table :organization, :primary_key => 'organization_id' do |t|
      t.string :name
      t.text :description
    end

    create_table :person, :primary_key => 'person_id' do |t|
      t.references :organization
      t.integer :calnet_uid
      t.string :name
      t.string :position
      t.string :email
      t.string :phone
    end
    add_index(:person, [:organization_id], :name => :organization_id_idx)
    add_index(:person, [:calnet_uid], :name => :calnet_uid_idx)

    create_table :business_process, :primary_key => 'business_process_id' do |t|
      t.string :name, :limit => size
      t.string :description, :limit => size
      t.integer :functional_org_id # t.references :organization
    end
    add_index(:business_process, [:functional_org_id], :name => :functional_org_id_idx)

    create_table :application, :primary_key => 'application_id' do |t|
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
    add_index(:application, [:disposition_id], :name => :application_disposition_id_idx)
    add_index(:application, [:maturity_id], :name => :maturity_id_idx)
    add_index(:application, [:owner_id], :name => :application_owner_id_idx)
    add_index(:application, [:admin_id], :name => :admin_id_idx)
    add_index(:application, [:technical_id], :name => :technical_id_idx)
    add_index(:application, [:testing_id], :name => :testing_id_idx)

    create_table :project_action, :primary_key => 'project_action_id' do |t|
      t.string :entity
      t.references :action_type
      t.integer :actor_id # t.references :person
      t.date :date
      t.text :description
    end
    add_index(:project_action, [:entity], :name => :entity_idx)
    add_index(:project_action, [:action_type_id], :name => :action_type_id_idx)
    add_index(:project_action, [:actor_id], :name => :actor_id_idx)

    create_table :role, :primary_key => 'role_id' do |t|
      t.string :name
      t.text :description
    end

    create_table :integration, :primary_key => 'integration_id' do |t|
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
    add_index(:integration, [:source_interface_id], :name => :source_interface_id_idx)
    add_index(:integration, [:target_interface_id], :name => :target_interface_id_idx)
    add_index(:integration, [:owner_id], :name => :integration_owner_id_idx)
    add_index(:integration, [:criticality_id], :name => :criticality_id_idx)
    add_index(:integration, [:last_action_id], :name => :integration_last_action_id_idx)

    create_table :data_field, :primary_key => 'data_field_id' do |t|
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
    add_index(:data_field, [:data_type_id], :name => :data_type_id_idx)
    add_index(:data_field, [:last_action_id], :name => :data_field_last_action_id_idx)

    create_table :message, :primary_key => 'message_id' do |t|
      t.string :name
      t.text :description
      t.references :message_format
      t.string :version
      t.references :disposition
      t.string :reference_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:message, [:message_format_id], :name => :message_format_id_idx)
    add_index(:message, [:disposition_id], :name => :message_disposition_id_idx)
    add_index(:message, [:last_action_id], :name => :message_last_action_id_idx)

    create_table :person_role, :primary_key => 'person_role_id' do |t|
      t.references :role
      t.references :person
    end
    add_index(:person_role, [:role_id], :name => :role_id_idx)
    add_index(:person_role, [:person_id], :name => :person_id_idx)

    create_table :security_level, :primary_key => 'security_level_id' do |t|
      t.string :description
    end

    create_table :edo, :primary_key => 'edo_id' do |t|
      t.string :name
      t.text :description
      t.integer :sor_id # t.references :application
      t.references :security_level
      t.string :version
      t.string :repository_uri
      t.integer :last_action_id # t.references :project_action
    end
    add_index(:edo, [:sor_id], :name => :sor_id_idx)
    add_index(:edo, [:security_level_id], :name => :security_level_id_idx)
    add_index(:edo, [:last_action_id], :name => :edo_last_action_id_idx)

    create_table :transfer_method, :primary_key => 'transfer_method_id' do |t|
      t.string :description
    end

    create_table :interface, :primary_key => 'interface_id' do |t|
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
    add_index(:interface, [:application_id], :name => :interface_application_id_idx)
    add_index(:interface, [:disposition_id], :name => :interface_disposition_id_idx)
    add_index(:interface, [:outbound_message_id], :name => :outbound_message_id_idx)
    add_index(:interface, [:inbound_message_id], :name => :inbound_message_id_idx)
    add_index(:interface, [:transfer_method_id], :name => :transfer_method_id_idx)
    add_index(:interface, [:web_service_type_id], :name => :web_service_type_id_idx)
    add_index(:interface, [:messaging_type_id], :name => :messaging_type_id_idx)
    add_index(:interface, [:last_action_id], :name => :interface_last_action_id_idx)

    create_table :web_service_type, :primary_key => 'web_service_type_id' do |t|
      t.string :description
    end

  end
end
