module PagesHelper
  def content_form_column(record, name)
    text_area(:record, :content, :name => name, :class => "tiny_mce")
  end
end
