import Swal from 'sweetalert2'

let bind_delete_file_event = function() {
    $('.js-delete-file').on('click', function () {
        let model = $(this).data('model')
        let field_name = $(this).data('field-name')
        let fakeimg_url = $(this).data('fakeimg-url')

        Swal.fire({
            title: '確認要刪除圖片？',
            showCancelButton: true,
            confirmButtonText: `確認`,
            cancelButtonText: `取消`,
        }).then((result) => {
            if (result.isConfirmed) {
                $(`#album-remove-${field_name}`).val('true')
                $(`#preview-${field_name}`).attr('src', fakeimg_url)
                $(`.js-preview-${field_name}-action-div`).remove()
            }
        })
    })
}

export {
    bind_delete_file_event
}
