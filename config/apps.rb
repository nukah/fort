Padrino.configure_apps do
  enable :sessions
  set :session_secret, '903667c9b215f6c7de110c70201687347cc30d717b11e5e4ecb237db6ccf276a'
  set :protection, true
  set :protect_from_csrf, true
  set :salt, '24f3b82a33cd757606eaf6d2ab1f96cd0cf4e70b84608d082196f4c96e3bc239'
end
Padrino.mount('Application::Fortification', :app_file => File.join(PADRINO_ROOT, 'app/app.rb')).to('/')
Padrino.mount("Application::Admin", :app_file => File.join(PADRINO_ROOT, 'admin/app.rb')).to("/admin")