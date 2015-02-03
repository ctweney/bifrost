attributes :name, :description, :sor_id, :version, :repository_uri
child :security_level do
  extends 'api/security_level'
end
child :last_action => 'last_action' do
  extends 'api/project_action'
end
