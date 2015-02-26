# Role-based code requires Roles 1 and 2 for Admin and Editor permisisons.
admin = Role.create({role_id: 1, name: 'Admin', description: 'Can manage all objects'})
Role.create({role_id: 2, name: 'Editor', description: 'Can manage all objects except Person and Role'})
Role.create({role_id: 3, name: 'Viewer', description: 'Can view all objects'})

Person.create(calnet_uid: '904715', name: 'Chris Tweney').roles << admin
Person.create(calnet_uid: '1013580', name: 'Steve Chan').roles << admin

