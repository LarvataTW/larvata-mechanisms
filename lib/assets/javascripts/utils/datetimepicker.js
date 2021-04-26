import 'jquery-datetimepicker'

// 初始化時間選擇器
let init_datetimepicker = function () {
    jQuery.datetimepicker.setLocale(I18n.locale)

    $(".datetimepicker").datetimepicker({
        inline: false,
        format: 'Y-m-d H:i',
        scrollMonth: false,
        todayButton: true,
        onChangeDateTime:function(dp, $input){
            toggle_is_filled($input)
        }
    })

    $(".datepicker").datetimepicker({
        inline: false,
        format: 'Y-m-d',
        timepicker: false,
        scrollMonth: false,
        todayButton: true,
        onChangeDateTime:function(dp, $input){
            toggle_is_filled($input)
        }
    })

    $(".monthpicker").datetimepicker({
        inline: false,
        format: 'Y-m',
        timepicker: false,
        scrollMonth: false,
        validateOnBlur: false,
        onChangeDateTime:function(dp, $input){
            toggle_is_filled($input)
        }
    })
}

// 用來解決選擇日期後，label 文字會回到輸入元件上的問題
let toggle_is_filled = function ($input) {
    if($input.val()) {
        $input.parents('.form-group').addClass(' is-filled')
    } else {
        $input.parents('.form-group').removeClass(' is-filled')
    }
}

export {
    init_datetimepicker
}