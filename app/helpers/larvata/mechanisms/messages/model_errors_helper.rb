module Larvata::Mechanisms::Messages::ModelErrorsHelper
  def display_error_messages(model)
    clear_alert_div_js = "$('div.alert').remove();".html_safe
    clear_error_messages_js = "$('span.error').remove();".html_safe

    display_error_messages_js = ""
    model.errors.messages.each do |message|
      display_error_messages_js += "$( '<span class=\"error text-danger\"><b>#{message[1].join('; ')}</b></span>' ).insertAfter( '##{target_element_id(model, message[0])}' );"
    end
    display_error_messages_js = display_error_messages_js.html_safe

    clear_alert_div_js + clear_error_messages_js + display_error_messages_js
  end

  private

  def target_element_id(model, message_key)
    main_element_part = model_name_from_record_or_class(model).name.underscore.gsub('/', '_')
    nested_element_part = message_key.to_s.gsub('.', '_attributes_')
    "#{main_element_part}_#{nested_element_part}"
  end
end
