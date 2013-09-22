Application::Admin.controllers :records do
  get :index do
    render 'records/index'
  end

  get :data, map: 'data/records', :provides => :json do
    records = Record.all.map { |record|
      record.serializable_hash(only: [:_id, :ident, :birthdate, :name, :mail, :title, :phone, :department, :active])
    }
    records.to_json
  end

  put :update_data, map: 'data/records/:id', :csrf_protection => false do
    record = Record.find(params[:id])
    if record
      if record.update_attributes(params[:record])
        {success: true}.to_json
      else
        {error: 'Operation unavailable.'}.to_json
      end
    else
      {error: "No record found."}.to_json
    end
  end

  get :new do
    @title = pat(:new_title, :model => 'record')
    @record = Record.new
    render 'records/new'
  end

  post :create do
    @record = Record.new(params[:record])
    if @record.save
      @title = pat(:create_title, :model => "record #{@record.id}")
      flash[:success] = pat(:create_success, :model => 'Record')
      params[:save_and_continue] ? redirect(url(:records, :index)) : redirect(url(:records, :edit, :id => @record.id))
    else
      @title = pat(:create_title, :model => 'record')
      flash.now[:error] = pat(:create_error, :model => 'record')
      render 'records/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "record #{params[:id]}")
    @record = Record.find(params[:id])
    if @record
      render 'records/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'record', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id, :csrf_protection => false do
    @title = pat(:update_title, :model => "record #{params[:id]}")
    @record = Record.find(params[:id])
    if @record
      if @record.update_attributes(params[:record])
        flash[:success] = pat(:update_success, :model => 'Record', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:records, :index)) :
          redirect(url(:records, :edit, :id => @record.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'record')
        render 'records/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'record', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Records"
    record = Record.find(params[:id])
    if record
      if record.destroy
        flash[:success] = pat(:delete_success, :model => 'Record', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'record')
      end
      redirect url(:records, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'record', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Records"
    unless params[:record_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'record')
      redirect(url(:records, :index))
    end
    ids = params[:record_ids].split(',').map(&:strip)
    records = Record.find(ids)

    if records.each(&:destroy)

      flash[:success] = pat(:destroy_many_success, :model => 'Records', :ids => "#{ids.to_sentence}")
    end
    redirect url(:records, :index)
  end
end
