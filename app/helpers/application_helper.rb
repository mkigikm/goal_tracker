module ApplicationHelper
  def title(page_title)
    content_for :title, page_title
  end

  def auth_token
    <<-HTML.html_safe
    <input type="hidden" name="authenticity_token"
     value="#{form_authenticity_token}">
    HTML
  end
end
