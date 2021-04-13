import 'select2'
import 'select2/dist/css/select2.css'

// 初始化select2：有 .select2 的 select 元件
let init_select2 = function () {
    $("select.select2:not(.select2-hidden-accessible)").select2({
        theme: "classic",
        width: '100%',
        placeholder: I18n.t('helpers.select.prompt'),
        allowClear: true,
        dropdownAutoWidth: true,
    })
}

export {
    init_select2
}