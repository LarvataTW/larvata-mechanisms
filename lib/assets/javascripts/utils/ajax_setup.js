let ajax_setup = function () {
    // $.ajaxSetup({
    //     timeout: 30000,
    //     headers: { // 讓 ajax request 都會加上 CSRF token
    //         'X-CSRF-Token': $.rails.csrfToken()
    //     }
    // })

    ajax_event_handler()
}

let ajax_event_handler = function () {
    $(document).ajaxSend(function(e, xhr, options) {
        let token =$("meta[name='csrf-token']").attr("content")
        xhr.setRequestHeader("X-CSRF-Token", token)
    })

    $(document).ajaxComplete(function(event, request, settings){
    })

    $(document).ajaxError(function(event, jqxhr, settings, thrownError){
    })
}

export {
    ajax_setup
}