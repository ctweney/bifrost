collection @apps
attributes :application_id, :name, :description, :legacy_flag
child :disposition do
  extends 'api/disposition'
end
child :maturity do
  extends 'api/maturity'
end
child :owner => 'owner' do
  extends 'api/person'
end
child :admin => 'admin' do
  extends 'api/person'
end
child :technical => 'technical' do
  extends 'api/person'
end
child :testing => 'testing' do
  extends 'api/person'
end
child :business_processes do
  extends 'api/business_process'
end
child :edos do
  extends 'api/edo'
end
