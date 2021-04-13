import 'jszip'
import 'datatables.net-bs4'
import 'datatables.net-buttons-bs4'
import 'datatables.net-buttons/js/buttons.html5'

let editor_i18n = function() {
    return {
        datetime: {
            months: I18n.t("date.abbr_month_names_without_empty"),
            weekdays: I18n.t("date.abbr_day_names")
        }
    }
}

let i18n = function() {
    return {
        aria: {
            sortAscending: `: ${I18n.t('datatables.sort_ascending')}`,
            sortDescending: `: ${I18n.t('datatables.sort_descending')}`
        },
        emptyTable: I18n.t('datatables.empty_table'),
        info: I18n.t('datatables.info'),
        infoEmpty: I18n.t('datatables.info_empty'),
        infoFiltered: I18n.t('datatables.info_filtered'),
        lengthMenu: I18n.t('datatables.length_menu'),
        zeroRecords: I18n.t('datatables.zero_records'),
        processing: I18n.t('datatables.processing'),
        paginate: {
            previous: I18n.t('datatables.previous'),
            next: I18n.t('datatables.next'),
            last: I18n.t('datatables.last'),
            first: I18n.t('datatables.first')
        },
        select: {
            rows: {
                _: I18n.t('datatables.selected_rows'),
                0: I18n.t('datatables.click_to_select'),
                1: I18n.t('datatables.only_one_row_selected')
            }
        }
    }
}

let length_menu = function () {
   return [
       [10, 20, 50, 100, 1000],
       [10, 20, 50, 100, I18n.t('helpers.datatables.length_menu_all')]
   ]
}

// 處理字串查詢
let column_string_filter = function(datatables, input_name) {
    let column_data = get_column_data( input_name )

    datatables = to_datatables(datatables)
    for(let tab_key in datatables) {
        let datatable = datatables[tab_key]
        if(typeof datatable.columns === 'function') datatable.columns( column_index(datatable, column_data) ).search( $('.filter-' + column_data).val() )
    }

    if(enter_keyup()){
        // datatable.draw()
    }
}

// 處理下拉選單、checkbox、radio查詢
let column_select_filter = function(datatables, input_name) {
    let column_data = get_column_data( input_name )

    datatables = to_datatables(datatables)
    for(let tab_key in datatables) {
        let datatable = datatables[tab_key]
        if(typeof datatable.columns === 'function') datatable.columns( column_index(datatable, column_data) ).search( $('.filter-' + column_data).val() )
    }
};

// 處理區間查詢
let column_range_filter = function(datatables, input_name) {
    let column_data = get_column_data(input_name)
    let start_filter = $('input[name="'+ column_data +'_start"]').val()
    let end_filter = $('input[name="'+ column_data +'_end"]').val()

    start_filter = remove_datetimepicker_mask(start_filter)
    end_filter = remove_datetimepicker_mask(end_filter)

    if(start_filter || end_filter) {
        datatables = to_datatables(datatables)
        for(let tab_key in datatables) {
            let datatable = datatables[tab_key]
            datatable.columns( column_index(datatable, column_data) ).search( start_filter + " - " + end_filter )
        }
    }

    if(enter_keyup()){
        // datatable.draw()
    }
}

// 關鍵字查詢
let keyword_filter = function(datatables, input_value){
    datatables = to_datatables(datatables)
    for(let tab_key in datatables) {
        let datatable = datatables[tab_key]
        if(typeof datatable.search === 'function') datatable.search( input_value )
    }
}

// 針對欄位設定查詢條件
let column_filter = function(datatable, input_name, input_value) {
    let column_data = get_column_data( input_name )
    if(typeof datatable.columns === 'function') datatable.columns( column_index(datatable, column_data) ).search( input_value )
}

// 是否按下 enter 鍵
let enter_keyup = function(){
    let keycode = (event.keyCode ? event.keyCode : event.which)
    return keycode == '13'
}

// 從查詢元件取得實際欄位名稱
let get_column_data = function(input_name){
    return input_name.replace(/\_start/g, '').replace(/_end/g, '')
}

// 用欄位名稱查詢在 datatables 中的 index
let column_index = function(datatable, column_data) {
    let column_index = 0
    if(typeof datatable.column === 'function') column_index = datatable.column('.col-' + column_data).index()
    return column_index
}

// 檢查是否為 Datatable 物件
let is_datatable = function(datatable){
    return $.fn.dataTable.isDataTable(datatable)
}

// to datatables JSON object
let to_datatables = function(datatables){
    if(is_datatable(datatables)){
        datatables = {"all": datatables}
    }
    return datatables
}

// 設定預設組織條件值
let assign_default_org_id = function(){
    $('#org_relation_org_id').trigger('select2:close')
}

// 設定要顯示「合計」的欄位 in footer row
let set_total_label_column = function(api, i) {
    $( api.column( i ).footer() ).html(I18n.t('helpers.datatables.total'))
}

// 設定要計算合計的欄位 in footer row
let set_total_column = function(api, i) {
    let total = api
        .column( i )
        .data()
        .reduce( function (a, b) {
            return common_numbers.numberVal(a).plus( common_numbers.numberVal(b) ).toNumber()
        }, 0 )

    $( api.column( i ).footer() ).html(total)
}

let submit_filter = function(datatable){
    datatable && datatable.draw()
}

let clear_filter = function(datatable){
    datatable&& datatable.search('').columns().search('')
    submit_filter(datatable)
}

let assign_datatable_filters = function (datatable) {
    // 關鍵字查詢
    if( $('#keyword_search').val() ) {
        keyword_filter(datatable, $('#keyword_search').val())
    }

    // 單一查詢條件值
    $( ".filter-condition" ).each(function( index ) {
        if( remove_datetimepicker_mask( $(this).val() ) ) {
            column_string_filter(datatable, $(this).attr('name'))
        }
    })

    // 範圍查詢條件值
    $('.filter-range-condition').each(function (index) {
        if( remove_datetimepicker_mask( $(this).val() ) ) {
            column_range_filter(datatable, $(this).attr('name'))
        }
    })

    // 選單查詢條件值
    $('.filter-select-condition').each(function (index) {
        if( $(this).val() ) {
            column_select_filter(datatable, $(this).attr('name'))
        }
    })
}

let remove_datetimepicker_mask = function (val) {
    val = val.replaceAll('____-__-__', '').replaceAll('__:__', '')
    return val
}

let binding_filter_event_for = function (datatable) {
    // 送出查詢
    $('button.filter-button').on('click', function(e){
        assign_datatable_filters(datatable)
        submit_filter(datatable)
    })

    // 清空查詢
    $('button.reset-button').on('click', function(e){
        $('input').val('')
        $('select').val('').trigger('change.select2')
        clear_filter(datatable)
    })
}

export {
    i18n,
    length_menu,
    editor_i18n,
    column_string_filter,
    column_range_filter,
    column_select_filter,
    keyword_filter,
    column_filter,
    enter_keyup,
    get_column_data,
    column_index,
    assign_default_org_id,
    set_total_label_column,
    set_total_column,
    binding_filter_event_for
}
