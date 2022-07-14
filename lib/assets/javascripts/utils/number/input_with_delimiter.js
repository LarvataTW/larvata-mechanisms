// 讓數字輸入框在 onBlur 後，可以調整其數字千分位以及小數位
let input_with_delimiter = function(selector, precision = 0) {
    var numberValue = $(selector).val().replaceAll(',', '');
    var resultValue = to2bits(numberValue).toFixed(precision);
    resultValue = numToMoneyField(resultValue);
    $(selector).val(resultValue);
}

let to2bits = function(flt) {
    if (parseFloat(flt) == flt) {
        return Math.round(flt * 100) / 100; // 到2位小數
    }
    else
        return 0;
}

//轉換為千分位格式
//將1234567.00轉換為1,234,567.00
let numToMoneyField = function(inputString) {
    let regExpInfo = /(\d{1,3})(?=(\d{3})+(?:$|\.))/g;
    let ret = inputString.toString().replace(regExpInfo, "$1,");
    return ret;
}

export {
    input_with_delimiter
}
