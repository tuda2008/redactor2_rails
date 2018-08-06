class Redactor2Rails::Image < Redactor2Rails::Asset
  mount_uploaders :data, Redactor2RailsImageUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end
end