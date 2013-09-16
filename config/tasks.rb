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

desc 'Create identicons for users'
task :user_idents do
  ident_dir = File.join(File.dirname(__FILE__), '../', 'public', 'idents')
  puts "Directory: #{ident_dir}"
  unless File.directory?(ident_dir)
    raise StandardError, "Identicon directory doesnt exist: #{ident_dir}"
  end
  require 'open-uri'
  require 'digest/md5'
  users = Record.where(active: true)
  users.each { |record|
    puts "Processing #{record.name}"
    image = "http://vanillicon.com/#{Digest::MD5.hexdigest(record.name)}_50.png"
    open(image) { |i| File.open("#{ident_dir}/#{record.id}.png", 'wb') { |f| f.puts i.read }}
    record.ident = "/idents/#{record.id}.png"
    record.save
  }
end