class Redactor2Rails::ImagesController < ApplicationController
  before_action :redactor2_authenticate_user!

  def create
    return if params[:file].nil?
    @results = []
    @errors = []
    params[:file].each do |file|
      @image = Redactor2Rails.image_model.new
      @image.data = file
      if @image.has_attribute?(:"#{Redactor2Rails.devise_user_key}")
        @image.send("#{Redactor2Rails.devise_user}=", redactor2_current_user)
        @image.assetable = redactor2_current_user
      end
      if @image.save
        @results << { id: @image.id, url: @image.url(:content) }
      else
        @errors << @image.errors
      end
    end

    if @results.length == 1
      render json: { filelink: @results[0].url(:content) }
    else
      render json: { data: @results, error: @errors.join(',') }
    end
  end

  private

  def redactor2_authenticate_user!
    if Redactor2Rails.image_model.new.has_attribute?(Redactor2Rails.devise_user)
      super
    end
  end
end