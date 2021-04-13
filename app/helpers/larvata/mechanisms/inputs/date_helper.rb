module Larvata::Mechanisms::Inputs::DateHelper
  def date_tag(form:, label:, value:, input_field_name:, input_class_name: "", disabled: false, state: nil)
    content_tag(:div, class: 'is-filled') do
      label_content = content_tag(:div) do
        label_tag(label, nil, class: 'bmd-label-floating')
      end

      input_content = content_tag(:div) do
        content_tag(:div, class: 'row') do
          text = content_tag(:div, class: 'col-md-12') do
              form.input_field(input_field_name, option = { value: value,
                                                            class: "form-control datepicker", 
                                                            as: :string, disabled: disabled})
          end

          text
        end
      end

      error_part = form.full_error input_field_name, class: "text-danger"

      label_content + input_content + error_part
    end
  end
end
