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

  def goal_status(goal)
    if goal.completed_on
      "Complete"
    elsif goal.due_by.nil? || Date.today < goal.due_by
      "In Progress"
    else
      "Overdue"
    end
  end
end
