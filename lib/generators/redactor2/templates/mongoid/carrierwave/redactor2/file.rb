class Redactor2Rails::File < Redactor2Rails::Asset
  mount_uploaders :data, Redactor2RailsFileUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end
end
