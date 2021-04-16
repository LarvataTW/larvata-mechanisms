require("bootstrap-material-design")
import * as bootbox from 'bootbox'

let open_modal = function (options) {
    let url = options.url || ''
    let title = options.title || ''
    let type = options.type || 'GET'
    let callback = options.callback
    let data = options.data || JSON.parse('{}')

    let default_data = {
        layout: 'larvata/mechanisms/modal'
    }

    $.ajax({
        url: url,
        type: type,
        dataType: 'HTML',
        data: {
            ...data,
            ...default_data
        }
    }).done(function (resolve) {
        let modal = bootbox.dialog({
            title: title,
            message: resolve,
            onEscape: function() {
                return true
            },
            backdrop: true,
            closeButton: false,
            animate: true,
            size: 'large',
            className: "draggable-modal resizable-modal bootbox-modal-width",
        })

        modal.init(function () {
            callback()
        })

        window.opened_modal = modal
    }).fail(function (xhr, ajaxOptions, thrownError) {
        console.log(xhr)
        console.log(ajaxOptions)
        console.log(thrownError)
    })
}

export {
    open_modal,
}