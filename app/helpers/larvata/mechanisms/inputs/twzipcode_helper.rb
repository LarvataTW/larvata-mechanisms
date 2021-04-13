module Larvata::Mechanisms::Inputs::TwzipcodeHelper
  # label: 此選擇器的 label 名稱
  # class_name: 此選擇器的 class 設定
  # county_name: 此選擇器縣市的 name 設定
  # district_name: 此選擇器鄉鎮市區的 name 設定
  # county_class_name: 此選擇器縣市的 class 設定
  # district_class_name: 此選擇器鄉鎮市區的 class 設定
  # county_value: 此選擇器鄉鎮市區的預設值
  # district_value: 此選擇器鄉鎮市區的預設值
  def twzipcode_tag(label: '', class_name: 'twzipcode', county_value: nil, district_value: nil, county_name: 'county', county_class_name: '', district_name: 'district', district_class_name: '', disabled: false)
    content_tag(:div, class: 'form-group') do
      label_content = content_tag(:div, class: 'col-md-6') do
        label_tag(label, nil, class: 'bmd-label-floating is-filled')
      end

      select_content = content_tag(:div, class: 'col-md-12') do
        content_tag(:div, class: class_name, data: {county: "#{county_value}", district: "#{district_value}"}) do
          content_tag(:div, class: 'row') do
            county_select = content_tag(:div, class: 'col-md-6') do
              select_tag(county_name, raw(''), class: "#{county_class_name} county select2", disabled: disabled)
            end

            district_select = content_tag(:div, class: 'col-md-6') do
              select_tag(district_name, raw(''), class: "#{district_class_name} district select2", disabled: disabled)
            end

            county_select + district_select
          end
        end
      end

      label_content + select_content
    end
  end
end
