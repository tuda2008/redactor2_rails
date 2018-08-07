class Redactor2Rails::Image < Redactor2Rails::Asset
  mount_uploader :data, Redactor2RailsImageUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end

  def as_json(opts = {})
    {
      thumb: self.url(:thumb),
      url: self.url_content,
      id: self.id.to_s,
      title: self.data_file_name.split('.').first
    }
  end
end