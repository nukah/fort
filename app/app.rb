module Application
  class Fortification < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    sprockets
    layout 'layout'
    enable  :sessions           # Disabled by default
  end
end