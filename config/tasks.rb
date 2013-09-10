require './config/boot'
desc 'Synchronize database with ldap'
task :sync do
  #Mongoid.load!(File.expand_path(File.join(File.dirname(__FILE__), 'mongoid.yml')), :production)
  ldap = Citadel::Backend.new File.expand_path(File.join(__FILE__, '../../', 'config.yml'))
  records = ldap.get_elements.reject { |rec| rec[:mail].nil? }
  records.each do |record|
    person = Record.find_or_create_by(mail: record[:mail])
    person.update_attributes(departments: record[:departments],
                             name: record[:name],
                             phone: record[:phone],
                             title: record[:title],
                             mobile: record[:mobile_phone],
                             dn: record[:dn],
                             active: true)
    person.touch(:created_at)
  end
end

desc 'Seed db from file'
task :user_seed do
  table = RemoteTable.new('./public/users2.xls', headers: ['name', 'mail', 'title' , 'mobile', 'department', 'phone']).rows
  table.delete_at(0)
  #Mongoid.load!(File.expand_path(File.join(File.dirname(__FILE__), 'mongoid.yml')), :production)
  table.each do |user|
    record = Record.where(mail: user['mail']).first
    if record
      record.update_attributes(title: user['title'], mobile: user['mobile'], phone: user['phone'])
      record.departments << user['department']
      record.save
    end
  end
end