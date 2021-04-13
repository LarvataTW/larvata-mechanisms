import {twzipcode_json} from './twzipcode/data'

// 初始化台灣縣市選擇器
let init_twzipcode = function (options = {}) {
    let twzipcode_el = options.el || '.twzipcode'
    let county_el = options.county_el || '.county'
    let district_el = options.district_el || '.district'
    let twzipcode_div = $(`${twzipcode_el}`)
    let county_select = $(`${twzipcode_el} ${county_el}`)
    let district_select = $(`${twzipcode_el} ${county_el}`)
    let county_value = options.county_value || twzipcode_div.data('county')
    let district_value = options.district_value || twzipcode_div.data('district')

    // 設定 county options
    counties().forEach(function(county_name) {
        county_select.append(new Option(county_name, county_name))
    })
    county_select.val(county_value || '').trigger("change")

    set_districts(twzipcode_el, district_el, county_value, district_value)

    county_select.on('change', function() {
        set_districts(twzipcode_el, district_el, $(this).val())
    })
}

let counties = function () {
    return twzipcode_json.map(rec => rec.name)
}

let districts_from = function (county_value) {
    let districts_array = twzipcode_json.filter(rec => rec.name === county_value).shift()
    return (districts_array && districts_array.districts) || []
}

let set_districts = function (twzipcode_el, district_el, county_value, district_value) {
    let district_select = $(`${twzipcode_el} ${district_el}`)
    let districts = districts_from(county_value)

    // 清空 district 選單值與 options
    district_select.val('').trigger("change")
    district_select.empty()

    // 設定 district options
    districts.forEach(function (dist) {
        district_select.append(new Option(dist.name, dist.name))
    })
    district_select.val(district_value || '').trigger("change")
}

export {
    init_twzipcode
}