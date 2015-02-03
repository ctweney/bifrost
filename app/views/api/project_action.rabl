attributes :entity, :date, :description
child :actor do
  extends 'api/person'
end
child :action_type do
  extends 'api/action_type'
end

