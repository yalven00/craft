module ApplicationHelper
  def nav_link(link_text, link_path, *args)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, class: class_name) do
      link_to link_text, link_path, *args
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def link_to_file(file, *args)
  #   file_name = file.file_file_name
  #   text = truncate(file_name, length: 10) + file_name[-5, 5]
  #   url = file.file.url
  #   link_to text, url, data: { tooltip: file_name }, target: :blank
  # end
end
