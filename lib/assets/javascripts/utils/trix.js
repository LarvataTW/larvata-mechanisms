import 'trix'
import './trix/richtext'
import {init_trix_attachment_event_handlers} from "./trix/attachments"

let init_trix = function() {
    init_trix_attachment_event_handlers()
}

export {
    init_trix
}
