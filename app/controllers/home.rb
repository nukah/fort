Application::Fortification.controllers :home do
  get :index, map: '/'  do
    render 'home/index'
  end

  get :data, map: '/data.json', :provides => :json do
    content_type :json
    records = Record.where(active: true).map { |record|
      record.serializable_hash(only: [:ident, :birthdate, :name, :mail, :title, :phone, :department])
    }
    records.to_json
  end
end
