Padrino.configure_apps do
  enable :sessions
  set :session_secret, '903667c9b215f6c7de110c70201687347cc30d717b11e5e4ecb237db6ccf276a'
  set :protection, true
  set :protect_from_csrf, true
end
Padrino.mount('Application::Fortification', :app_file => File.join(PADRINO_ROOT, 'app/app.rb')).to('/')
Padrino.mount("Application::Admin", :app_file => File.join(PADRINO_ROOT, 'admin/app.rb')).to("/admin")