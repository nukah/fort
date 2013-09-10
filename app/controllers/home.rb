Application::Fortification.controllers :home do
  get :index, map: '/'  do
    render 'home/index'
  end

  get :data, map: '/data.json', :provides => :json do
    content_type :json
    @records = Record.where(active: true).map { |record|
      record.serializable_hash(only: [:name, :mail, :title, :phone, :departments])
    }
    @records.to_json
  end
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end


end
