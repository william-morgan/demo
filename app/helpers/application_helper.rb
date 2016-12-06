module ApplicationHelper
  def button_to_with_icon(text, path, classes)
    form_tag path, :method => :post do
      button_tag(classes) do
        raw text
      end
    end
  end
end
