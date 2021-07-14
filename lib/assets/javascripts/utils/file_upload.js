import {
    Core,
    FileInput,
    Informer,
    ProgressBar,
    ThumbnailGenerator,
    Dashboard,
    XHRUpload,
    AwsS3,
    AwsS3Multipart,
    StatusBar,
} from 'uppy'

const randomstring = require('randomstring')

const single_file_upload = (fileInput) => {
    const imagePreview = document.getElementById(fileInput.dataset.previewElement)
    const formGroup = fileInput.parentNode
    let disabled = fileInput.disabled
    let label = fileInput.dataset.label
    let origin_width = imagePreview.width
    let origin_height = imagePreview.height

    formGroup.removeChild(fileInput)

    const uppy = fileUpload(fileInput)

    if(!disabled) {
        uppy
            .use(FileInput, {
                target: formGroup,
                locale: { strings: { chooseFiles: label || 'Choose file' } },
                disabled: true
            })
    }

    uppy
        .use(Informer, {
            target: formGroup,
        })
        .use(ProgressBar, {
            target: imagePreview.parentNode,
        })
        .use(StatusBar, {

        })
        .use(ThumbnailGenerator, {
            thumbnailWidth: 600,
        })

    uppy.on('upload-success', (file, response) => {
        const fileData = uploadedFileData(file, response, fileInput)
        let metadata = JSON.parse(fileData).metadata

        // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
        const hiddenInput = document.getElementById(fileInput.dataset.uploadResultElement)
        hiddenInput.value = fileData

        if(metadata.mime_type.indexOf('image') === -1) {
            imagePreview.src = `/assets/file_types/${metadata.filename.split('.').pop()}.png`
            imagePreview.width = 128
            imagePreview.height = 128
        }
    })

    uppy.on('upload-error', (file, error, response) => {
        console.log('error with file:', file.id)
        console.log('error message:', error)
    })

    uppy.on('thumbnail:generated', (file, preview) => {
        imagePreview.src = preview
        imagePreview.width = origin_width
        imagePreview.height = origin_height
    })
}

const multiple_file_upload = (fileInput) => {

    const formGroup = fileInput.parentNode
    let disabled = fileInput.disabled

    const uppy = fileUpload(fileInput)

    uppy
        .use(Dashboard, {
            target: formGroup,
            inline: true,
            height: 300,
            replaceTargetContent: true,
            disabled: disabled
        })

    uppy.on('upload-success', (file, response) => {
        let fileInputName = fileInput.name.replace('][]', `_attributes][${randomstring.generate()}][file]`)
        const hiddenField = document.createElement('input')

        hiddenField.type = 'hidden'
        hiddenField.name = fileInputName
        hiddenField.value = uploadedFileData(file, response, fileInput)

        document.querySelector('form[enctype="multipart/form-data"]').appendChild(hiddenField)
    })
}

const fileUpload = (fileInput) => {
    const uppy = Core({
        id: fileInput.id,
        autoProceed: true,
        restrictions: restrictions_json(fileInput.dataset.restrictions)
    })

    if (fileInput.dataset.uploadServer == 's3') {
        uppy.use(AwsS3, {
            companionUrl: '/', // will call Shrine's presign endpoint mounted on `/s3/params`
        })
    } else if (fileInput.dataset.uploadServer == 's3_multipart') {
        uppy.use(AwsS3Multipart, {
            companionUrl: '/' // will call uppy-s3_multipart endpoint mounted on `/s3/multipart`
        })
    } else {
        uppy.use(XHRUpload, {
            endpoint: '/uploads', // Shrine's upload endpoint
        })
    }

    return uppy
}

const uploadedFileData = (file, response, fileInput) => {
    if (fileInput.dataset.uploadServer == 's3') {
        const id = file.meta['key'].match(/^cache\/(.+)/)[1]; // object key without prefix

        return JSON.stringify(fileData(file, id))
    } else if (fileInput.dataset.uploadServer == 's3_multipart') {
        const id = response.uploadURL.match(/\/cache\/([^\?]+)/)[1]; // object key without prefix

        return JSON.stringify(fileData(file, id))
    } else {
        return JSON.stringify(response.body)
    }
}

// constructs uploaded file data in the format that Shrine expects
const fileData = (file, id) => ({
    id: id,
    storage: 'cache',
    metadata: {
        size:      file.size,
        filename:  file.name,
        mime_type: file.type,
    }
})

let init_file_upload = function () {
    $(':file').each(function (index) {
        let fileInput = $(this).get(0)
        if (fileInput.multiple) {
            multiple_file_upload(fileInput)
        } else {
            single_file_upload(fileInput)
        }
    })
}

let restrictions_json = function (restrictions_str) {
    let _json = JSON.parse(restrictions_str)
    if(_json.allowedFileTypes) {
        _json.allowedFileTypes = _json.allowedFileTypes.split(',')
    }
    return _json
}

export { init_file_upload }
