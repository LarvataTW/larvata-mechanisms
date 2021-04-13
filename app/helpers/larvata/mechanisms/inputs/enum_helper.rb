module Larvata::Mechanisms::Inputs::EnumHelper
  # label: enum 欄位說明
  # name: enum 欄位名稱
  # class_name: enum class 設定
  # enum_values: enum 選項
  # value: 目前選單值
  # multiple: 是否為多選，預設為 false
  # disabled: 是否禁用
  def enum_tag(label: '', name:, enum_values:, value:, class_name: '', disabled: false)
    select_options = Hash[enum_values.collect { |enum_value| [enum_value, enum_value.text] } ]

    content_tag(:div, class: 'form-group') do
      label_content = content_tag(:div, class: 'col-md-6') do
        label_tag(label, nil, class: 'bmd-label-floating is-filled')
      end

      select_content = content_tag(:div, class: 'col-md-12') do
        content_tag(:div, class: class_name) do
          content_tag(:div, class: 'row') do
            select = content_tag(:div, class: 'col-md-12') do
              select_tag(name, raw(raw_select_options(select_options, value)), class: "#{class_name} select2", disabled: disabled)
            end

            select
          end
        end
      end

      label_content + select_content
    end
  end

  private

  def raw_select_options(select_options, value)
    select_options.map {|k, v| "<option value='#{k}' #{check_selected_option(k, value)}>#{v}</option>"}.join
  end

  def check_selected_option(k, value)
    k == value ? 'selected' : ''
  end
end
