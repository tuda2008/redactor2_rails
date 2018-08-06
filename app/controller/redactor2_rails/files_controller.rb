class Redactor2Rails::FilesController < ApplicationController
  before_action :redactor2_authenticate_user!

  def index
    if Redactor2Rails.file_model.new.has_attribute?(:"#{Redactor2Rails.devise_user_key}")
      @files = Redactor2Rails.file_model.where({ Redactor2Rails.devise_user_key => redactor2_current_admin_user.id })
    else
      @files = Redactor2Rails.file_model.all
    end
    render :json => @files.to_json
  end

  def create
    return if params[:file].nil?
    @results = {}
    @errors = []
    params[:file].each_with_index do |file, i|
      @file = Redactor2Rails.file_model.new
      @file.data = file
      if @file.has_attribute?(:"#{Redactor2Rails.devise_user_key}")
        user = redactor2_current_admin_user
        @file.send("#{Redactor2Rails.devise_user}=", user)
        @file.assetable = user
      end
      if @file.save
        @results["file-#{i}"] = { url: @file.url, name: @file.filename }
      else
        @errors << @file.errors
      end
    end

    if @errors.length > 0
      render json:  { error: @errors.join(',') }
    else
      render json: @results
    end
  end

  private

  def redactor2_authenticate_user!
    if Redactor2Rails.file_model.new.has_attribute?(Redactor2Rails.devise_user)
      super
    end
  end
end