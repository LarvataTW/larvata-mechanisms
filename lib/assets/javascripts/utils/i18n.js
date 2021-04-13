let set_default_locale = function () {
    I18n.locale = $('body').data('locale')
}

export {
    set_default_locale
}