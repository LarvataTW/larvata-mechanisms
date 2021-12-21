module Larvata::Mechanisms::Filters::KeywordHelper
  def keyword_filter_tag(keyword_label)
    content_tag(:div, class: 'bmd-form-group form-group') do
      label_tag(keyword_label, nil, class: 'bmd-label-floating') +
        text_field_tag(:keyword_search, nil, class: 'form-control')
    end
  end
end
