module Larvata::Mechanisms::Inputs::FilesHelper
  # form: 表單物件
  # uploader: 要使用的 Uploader 物件
  # disabled: 是否禁用，預設為 false
  # association: 關聯的檔案上傳 model，預設為 :attachments
  # preview_thumbnail: 縮圖類別
  def files_tag(label:, form:, uploader:, disabled: false, association: :attachments, preview_thumbnail: nil)
    file_field = content_tag(:div, class: 'col-md-12') do
      content_tag(:div, class: 'bmd-form-group form-group') do
        form.file_field association, multiple: true, disabled: disabled,
                        accept: uploader::ALLOWED_TYPES.join(","),
                        data: {
                          upload_server: upload_server,
                          restrictions: {
                            maxFileSize: defined?(uploader::MAX_SIZE) ? uploader::MAX_SIZE : nil,
                            minFileSize: defined?(uploader::MIN_SIZE) ? uploader::MIN_SIZE : nil,
                            maxTotalFileSize: defined?(uploader::MAX_TOTAL_SIZE) ? uploader::MAX_TOTAL_SIZE : nil,
                            maxNumberOfFiles: defined?(uploader::MAX_NUMBER) ? uploader::MAX_NUMBER : nil,
                            minNumberOfFiles: defined?(uploader::MIN_NUMBER) ? uploader::MIN_NUMBER : nil,
                            allowedFileTypes: defined?(uploader::ALLOWED_TYPES) ? uploader::ALLOWED_TYPES.join(",") : nil,
                          },
                        }
      end
    end

    attachments_list = content_tag(:div, class: 'row') do
      form.simple_fields_for association do |pf|
        content_tag(:div, class: 'col-md-3') do
          file = pf&.object&.file
          image_url = image?(file) ? files_preview_url(pf&.object, preview_thumbnail) : "larvata/mechanisms/file_types/#{extname(file)}.png"

          content_tag(:div, class: 'row') do
            image_part = content_tag(:div, class: 'col-md-12') do
              image_tag image_url, width: 128, title: filename(file), class: 'img-thumbnail'
            end

            desc_part = content_tag(:div, class: 'col-md-12') do

              content_tag(:div, class: 'row') do
                icon_part = content_tag(:div, class: 'col-md-1') do
                  tag.span class: 'material-icons' do
                    'delete_forever'
                  end
                end

                destroy_part = content_tag(:div, class: 'col-md-1') do
                  pf.check_box :_destroy
                end

                label_part = content_tag(:div, class: 'col-md-8') do
                  label_tag filename(file)
                end

                disabled ? label_part : icon_part + destroy_part + label_part
              end
            end

            desc_part + image_part
          end
        end
      end
    end

    disabled ? attachments_list : file_field + attachments_list
  end

  private

  def files_preview_url(object, preview_thumbnail)
    (preview_thumbnail ? object&.file_url(preview_thumbnail) : object&.file_url).presence
  end
end
