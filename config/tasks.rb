require './config/boot'
desc 'Synchronize database with ldap'
task :sync do
  puts "Citadel: Synchronizing databases AD < - > Fortification."
  ldap = Citadel::Backend.new File.expand_path(File.join(__FILE__, '../../', 'config.yml'))
  entries = ldap.get_elements.reject { |entry| entry[:mail].nil? }
  puts "Citadel: Found #{entries.size} records in AD database."
  entries.each do |element|
    record = Record.find_or_create_by(mail: element[:mail])
    if record.name == nil
      puts "Citadel: Processing new user #{element["name"]}."
    else
      puts "Citadel: Processing existing user #{record.name}."
    end
    updates = element.reject { |k,v| (v.nil? || !Citadel::Connector::ATTRIBUTES.values.include?(k) || record.send(k) == v) }
    puts "Citadel: Updates for #{element["name"]} include -> #{updates}"
    record.update_attributes(updates)
    record.save
  end
end

desc 'Seed db from file'
task :user_seed do
  table = RemoteTable.new('./public/users2.xls', headers: ['name', 'mail', 'title' , 'mobile', 'department', 'phone']).rows
  table.delete_at(0)
  table.each do |user|
    record = Record.where(mail: user['mail']).first
    if record
      record.update_attributes(title: user['title'], mobile: user['mobile'], phone: user['phone'])
      record.departments << user['department']
      record.save
    end
  end
end