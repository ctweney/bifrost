# Role-based code requires Roles 1 and 2 for Admin and Editor permisisons.
admin = Role.create({role_id: 1, name: 'Admin', description: 'Can manage all objects'})
Role.create({role_id: 2, name: 'Editor', description: 'Can manage all objects except Person and Role'})
Role.create({role_id: 3, name: 'Viewer', description: 'Can view all objects'})

Person.create(calnet_uid: '904715', name: 'Chris Tweney').roles << admin
Person.create(calnet_uid: '10746', name: 'Russ Connacher').roles << admin
Person.create(calnet_uid: '1013580', name: 'Steve Chan').roles << admin
Person.create(calnet_uid: '980853', name: 'Tamer Sakr').roles << admin
Person.create(calnet_uid: '304844', name: 'Adam Cohen').roles << admin
Person.create(calnet_uid: '17232', name: 'Karin Bliman').roles << admin
