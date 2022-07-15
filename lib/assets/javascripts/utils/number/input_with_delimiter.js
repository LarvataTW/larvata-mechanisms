// 傳入數字格式的值，對其增加數字千分位以及小數位
let number_with_delimiter = function(number_format_value, precision = 0) {
    let number_value = number_without_delimiter(number_format_value);
    let result_value = parseFloat(number_value).toFixed(precision);
    result_value = add_delimiter_to_number(result_value);
    return result_value;
}

// 取得數字輸入框的值，將其數字千分位移除
let number_without_delimiter = function(number_format_value) {
    if(number_format_value) {
        number_format_value = number_format_value.toString().replaceAll(',', '');
    }
    return number_format_value;
}

//轉換為千分位格式
let add_delimiter_to_number = function(inputString) {
    let regExpInfo = /(\d{1,3})(?=(\d{3})+(?:$|\.))/g;
    let ret = inputString.toString().replace(regExpInfo, "$1,");
    return ret;
}

let input_number_with_delimiter = function(selector, precision = 0) {
    let number_value = $(selector).val()
    number_value = number_without_delimiter(number_value)
    let result_value = number_with_delimiter(number_value, precision)
    $(selector).val(result_value);
}

export {
    number_with_delimiter,
    number_without_delimiter,
    input_number_with_delimiter
}
