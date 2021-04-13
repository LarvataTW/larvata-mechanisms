module Larvata::Mechanisms::Inputs::TrixHelper
  def trix_tag(label: '', name:, value:, class_name: "", disabled: false)
    content_tag(:div, class: 'is-filled') do
      label_content = content_tag(:div) do
        label_tag(label, nil, class: 'bmd-label-floating')
      end

      trix_content = content_tag(:div) do
        content_tag(:div, class: '') do
          content_tag(:div, class: 'row') do
            text = content_tag(:div, class: 'col-md-12') do
              rich_text_area_tag(name, value)
            end

            text
          end
        end
      end

      label_content + trix_content
    end
  end
end
