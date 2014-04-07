#encoding: utf-8
role_admin = Role.create(name: 'admin')
User.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'adminadmin', roles: [role_admin])

Question.create({"name" => "¿QUÉ ES LO QUE METERÍAS EN TU MALETA PARA IR A CANNES FRANCIA, CON ACCESO TOTAL Y POR QUÉ?"})
Question.create({"name" => "AL LLEGAR A CANNES FRANCIA, CON ACCESO TOTAL, ¿QUÉ SERÍA LO PRIMERO QUE HARÍAS Y POR QUÉ?"})
Question.create({"name" => "¿POR QUÉ SERÍAS LA PERSONA INDICADA PARA IR A CANNES FRANCIA CON ACCESO TOTAL Y TODO PAGADO?"})
