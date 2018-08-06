class Redactor2Rails::FilesController < ApplicationController
  before_action :redactor2_authenticate_user!

  def index
    @files = Redactor2Rails.file_model.where(
        Redactor2Rails.file_model.new.respond_to?(Redactor2Rails.devise_user) ? {Redactor2Rails.devise_user_key => redactor2_current_user.id } : { })
    render :json => @files.to_json
  end

  def create
    return if params[:file].nil?
    @results = []
    @errors = []
    params[:file].each do |file|
      @file = Redactor2Rails.file_model.new
      @file.data = file
      if @file.has_attribute?(:"#{Redactor2Rails.devise_user_key}")
        @file.send("#{Redactor2Rails.devise_user}=", redactor2_current_user)
        @file.assetable = redactor2_current_user
      end
      if @file.save
        @results << { url: @file.url, name: @file.filename }
      else
        @errors << @file.errors
      end
    end

    if @results.length == 1
      render json: @results[0]
    else
      if @errors.length > 0
        render json:  { error: @errors.join(',') }
      else
        render json: @results
      end
    end
  end

  private

  def redactor2_authenticate_user!
    if Redactor2Rails.file_model.new.has_attribute?(Redactor2Rails.devise_user)
      super
    end
  end
end