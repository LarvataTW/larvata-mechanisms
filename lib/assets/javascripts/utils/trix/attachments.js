let upload = function (attachment) {
    let csrfToken = $('meta[name="csrf-token"]').attr('content')
    let file = attachment.file
    let form = new FormData
    let endpoint = "/common/trix/images"
    let xhr = new XMLHttpRequest

    form.append("Content-Type", file.type)
    form.append("attachment[file]", file)

    xhr.open("POST", endpoint, true)
    xhr.setRequestHeader("X-CSRF-Token", csrfToken)

    xhr.upload.onprogress = function(event) {
        let progress = event.loaded / event.total * 100
        return attachment.setUploadProgress(progress)
    }

    xhr.onload = function() {
        if (this.status >= 200 && this.status < 300) {
            let data = JSON.parse(this.responseText)
            return attachment.setAttributes({
                url: data.url,
                href: data.url
            })
        }
    }

    return xhr.send(form)
}

let init_trix_attachment_event_handlers = function () {
    document.addEventListener("trix-attachment-add", function(event) {
        let attachment = event.attachment
        if (attachment.file) {
            return upload(attachment)
        }
    })

    document.addEventListener("trix-attachment-remove", function(event) {
        let attachment = event.attachment
        let id = find_attachment_id(attachment.previewURL)

        $(document).ajaxSend(function(e, xhr, options) {
            let token =$("meta[name='csrf-token']").attr("content")
            xhr.setRequestHeader("X-CSRF-Token", token)
        })

        $.ajax({
            url: `/common/trix/images/${id}`,
            type: 'DELETE',
            dataType: 'JSON',
        }).done(function (data) {
        }).fail(function (xhr, ajaxOptions, thrownError) {
            console.log(xhr)
            console.log(ajaxOptions)
            console.log(thrownError)
        })
    })
}

let find_attachment_id = function (file_url) {
    let attachment_id = 0
    const regex = /trix\/(\d+)\/file/g
    const str = `http://127.0.0.1:3000/uploads/trix/121/file/94fc5cda12646e2f0ef14a10b087b2df.jpg`
    let m

    while ((m = regex.exec(str)) !== null) {
        // This is necessary to avoid infinite loops with zero-width matches
        if (m.index === regex.lastIndex) {
            regex.lastIndex++
        }

        // The result can be accessed through the `m`-variable.
        m.forEach((match, groupIndex) => {
            attachment_id = match
        })
    }

    return attachment_id
}


export {
    init_trix_attachment_event_handlers
}