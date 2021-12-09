module Larvata::Mechanisms::Messages::ModelErrorsHelper
  def display_error_messages(model)
    @model = model
    clear_alert_div_js = "$('div.alert').remove();".html_safe
    clear_error_messages_js = "$('span.error').remove();".html_safe

    @display_error_messages_js = ""
    @model.errors.messages.each do |message|
      display_master_and_one_to_one_error_message(message)

      collect_nested_models(message)
    end

    display_nested_models_error_messages

    @display_error_messages_js = @display_error_messages_js.html_safe

    clear_alert_div_js + clear_error_messages_js + @display_error_messages_js
  end

  private

  def target_element_id(message_key)
    "#{main_element_part}_#{nested_element_part(message_key)}"
  end

  def main_element_part
    model_name_from_record_or_class(@model).name.underscore.gsub('/', '_')
  end

  def nested_element_part(message_key)
    message_key.to_s.gsub('.', '_attributes_')
  end

  # 收集 nested models 相關資訊
  def collect_nested_models(message)
    message_key = message[0]

    nested_model_name = message_key.to_s.split('.')[0]
    nested_column_name = message_key.to_s.split('.')[1]

    @nested_models ||= []
    if nested_model_name and nested_column_name
      @nested_models << {
        model_name: nested_model_name, # nested model 名稱，如：services
        column_name: nested_column_name, # nested model column 名稱，如：name
        start_with_selector: target_element_id(message[0]).gsub(nested_column_name.to_s, '') # 用來定位輸入元件的起始 jquery selector，如：quotation_services_attributes_
      }
    end

    @nested_models.uniq!
  end

  # 顯示主檔、關聯 model（一對一） 的錯誤訊息
  def display_master_and_one_to_one_error_message(message)
    @display_error_messages_js += "$( '<span class=\"error text-danger\"><b>#{message[1].join('；')}</b></span>' ).insertAfter( '##{target_element_id(message[0])}' );"
  end

  # 顯示關聯 model（一對多） 的錯誤訊息
  def display_nested_models_error_messages
    @nested_models.each do |nested_model|
      # 掃描有錯誤訊息的 nested 關聯資料，然後將對應的錯誤訊息附加上去
      @model.send(nested_model[:model_name]).each_with_index do |_nested_model, index|
        error_message = _nested_model.errors.full_messages_for(nested_model[:column_name]).join('；')
        if error_message
          # 定位有錯誤訊息的輸入元件，如：$('[id^=quotation_services_attributes_][id$=name]').eq( 第幾筆資料的 index )
          start_with = nested_model[:start_with_selector]
          end_with = nested_model[:column_name]
          insertAfterTarget = "$('[id^=#{start_with}][id$=#{end_with}], [id^=#{start_with}][id$=#{end_with}_id]').eq(#{index})"
          @display_error_messages_js += "$( '<span class=\"error text-danger\"><b>#{error_message}</b></span>' ).insertAfter( #{insertAfterTarget} );"
        end
      end
    end
  end
end
