module ApplicationHelper
  def bootstrap_class_for flash_type
    css = { success: 'alert-success', error: 'alert-danger', warning: 'alert-warning'}[flash_type.to_sym]
    if !!css
      css
    else
      'alert-warning'
    end
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "container text-center alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'})
        concat message
      end)
      flash.clear
    end
    nil
  end
end
