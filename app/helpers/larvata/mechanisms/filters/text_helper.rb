module Larvata::Mechanisms::Filters::TextHelper
  # label: 此查詢欄位的 label 名稱
  # class_name: 此查詢欄位的 class 設定
  # column_name: 此查詢欄位名稱
  def text_filter_tag(label: '', class_name: '', column_name: '')
    content_tag(:div, class: 'bmd-form-group form-group') do
      label_tag(label, nil, class: 'bmd-label-floating') +
        text_field_tag("#{column_name}", nil, class: "form-control #{class_name} filter-#{column_name} filter-condition", autocomplete: 'off')
    end
  end
end
