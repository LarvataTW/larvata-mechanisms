module Larvata::Mechanisms::Filters::RangeHelper
  def range_filter_tag(type = 'number', start_label, end_label, column_name)
    start_tags = content_tag(:div, class: 'col-md-6') do
      content_tag(:div, class: 'form-group bmd-form-group') do
        label_tag(start_label, nil, class: 'bmd-label-floating') +
          field_tag(type, column_name, 'start')
      end
    end

    end_tags = content_tag(:div, class: 'col-md-6') do
      content_tag(:div, class: 'form-group bmd-form-group') do
        label_tag(end_label, nil, class: 'bmd-label-floating') +
          field_tag(type, column_name, 'end')
      end
    end

    content_tag(:div, class: 'row') do
      start_tags + end_tags
    end
  end

  private

  def field_tag(type, column_name, suffix)
    case type
    when 'number'
      number_field_tag("#{column_name}_#{suffix}", nil, class: "form-control filter-#{column_name} filter-range-#{column_name} filter-range-condition", autocomplete: 'off')
    else
      text_field_tag("#{column_name}_#{suffix}", nil, class: "form-control #{type} filter-#{column_name} filter-range-#{column_name} filter-range-condition", autocomplete: 'off')
    end
  end
end