# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role_admin = Role.create(name: 'admin')
User.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'adminadmin', roles: [role_admin])

Question.create({"name" => "QUE ES LO QUE METERIAS EN TU MALETA PARA IR A CANNES CON ACCESO TOTAL Y POR QUE?"})
Question.create({"name" => "AL LLEGAR A CANNES CON ACCESO TOTAL, QUE SERIA LO PRIMERO QUE HARIAS Y POR QUE?"})
Question.create({"name" => "POR QUE SERIAS LA PERSONA INDICADA PARA IR A UN VIAJE A CANNES, FRANCIA CON ACCESO TOTAL Y TODO PAGADO?"})
