module Application
  class Fortification < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    register Padrino::Admin::AccessControl

    sprockets
    layout 'layout'
    set :admin_model, 'Account'
    set :login_page,  '/admin/sessions/new'

    enable  :sessions
    disable :store_location
    # access_control.roles_for :any do |role|
    #   role.protect '/'
    #   role.allow   '/sessions'
    # end

    # access_control.roles_for :user do |role|
    #   role.project_module :listing, '/'
    # end
    # access_control.roles_for :admin do |role|
    #   role.project_module :listing, '/'
    # end
  end
end