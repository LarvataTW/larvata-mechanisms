module Larvata::Mechanisms::Inputs::CollectionHelper
  # form: 表單物件
  # label: 欄位說明
  # field_name: 欄位名稱
  # collection: 可選擇項目
  # value_method: 可透過指定方法取得值，預設為 :first
  # text_method: 可透過指定方法取得顯示文字，預設為 :last
  # value: 被選取的值
  # input_class_name: 項目的 class
  # disabled: 是否禁用，預設為 false
  def radio_buttons_tag(form:, label:, field_name:, collection: [], value_method: :first, text_method: :last, value: nil, input_class_name: '', disabled: false)
    content_tag(:div, class: 'bmd-form-group') do
      content_tag(:div, class: 'form-group is-filled') do
        label_part = label_tag(label, nil, class: 'bmd-label-floating')
        radio_part = form.collection_radio_buttons field_name, collection, value_method, text_method,
                                                   include_hidden: false, checked: value,
                                                   item_wrapper_class: "radio-inline" do |input|
          input.label(class: "radio-inline mr-3") {
            input.radio_button(disabled: disabled, class: "#{input_class_name} mr-1") + input.text
          }
        end

        error_part = form.full_error field_name, class: 'text-danger'

        label_part + radio_part + error_part
      end
    end
  end

  # form: 表單物件
  # label: 欄位說明
  # field_name: 欄位名稱
  # collection: 可選擇項目
  # value_method: 可透過指定方法取得值，預設為 :first
  # text_method: 可透過指定方法取得顯示文字，預設為 :last
  # value: 被選取的值
  # input_class_name: 項目的 class
  # disabled: 是否禁用，預設為 false
  def check_boxes_tag(form:, label:, field_name:, collection: [], value_method: :first, text_method: :last, value: nil, input_class_name: '', disabled: false)
    content_tag(:div, class: 'bmd-form-group') do
      content_tag(:div, class: 'form-group is-filled') do
        label_part = label_tag(label, nil, class: 'bmd-label-floating')
        check_box_part = form.collection_check_boxes field_name, collection, value_method, text_method,
                                                     include_hidden: false, checked: value,
                                                     item_wrapper_class: "checkbox-inline" do |input|
          input.label(class: "radio-inline mr-3") {
            input.check_box(disabled: disabled, class: "#{input_class_name} mr-1") + input.text
          }
        end

        error_part = form.full_error field_name, class: 'text-danger'

        label_part + check_box_part + error_part
      end
    end
  end

  # form: 表單物件
  # label: 欄位說明
  # field_name: 欄位名稱
  # collection: 可選擇項目
  # value_method: 可透過指定方法取得值，預設為 :first
  # text_method: 可透過指定方法取得顯示文字，預設為 :last
  # input_class_name: 項目的 class
  # disabled: 是否禁用，預設為 false
  # allow_clear: 是否可清空，預設為 true
  # include_blank: 是否可為空，預設為 false
  def select2_tag(form:, label:, field_name:, collection: [], value_method: :first, text_method: :last, input_class_name: 'select2', value: '', disabled: false, multiple: false, allow_clear: true, include_blank: false)
    allow_clear_class = allow_clear ? 'allow-clear' : ''

    content_tag(:div, class: 'bmd-form-group') do
      content_tag(:div, class: 'form-group is-filled') do
        label_part = label_tag(label, nil, class: 'bmd-label-floating')
        select_part = form.collection_select field_name, collection, value_method, text_method,
                                             {
                                               include_hidden: false,
                                               include_blank: include_blank,
                                               selected: value
                                             },
                                             {
                                               class: "form-control #{input_class_name} #{allow_clear_class}",
                                               multiple: multiple,
                                               disabled: disabled
                                             }

        error_part = form.full_error field_name, class: 'text-danger'

        label_part + select_part + error_part
      end
    end
  end

  # 將 enumerize 的 values 轉成 { :value => text } 格式
  def enumerize_texts(enumerize_values)
    Hash[enumerize_values.collect { |enum_value| [enum_value, enum_value.text] } ]
  end
end
