module Larvata::Mechanisms::Filters::SelectHelper
  # label: enum 欄位說明
  # name: 欄位名稱
  # collection: 選項
  # value: 目前選單值
  # class_name: class 設定
  # multiple: 是否為多選，預設為 false
  # disabled: 是否禁用
  def select_filter_tag(label:, name:, collection: [], value: '', class_name: '', multiple: false, disabled: false)
    content_tag(:div, class: 'bmd-form-group form-group') do
      label_tag(label, nil, class: 'bmd-label-floating') +
        select_tag(name,
                   options_for_select(collection, value),
                   class: "form-control filter-#{name} filter-select-condition #{class_name}",
                   disabled: disabled,
                   multiple: multiple)
    end
  end
end
