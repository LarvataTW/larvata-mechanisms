module Larvata::Mechanisms::Inputs::FilesHelper
  # form: 表單物件
  # uploader: 要使用的 Uploader 物件
  # disabled: 是否禁用，預設為 false
  # association: 關聯的檔案上傳 model，預設為 :attachments
  def files_tag(label:, form:, uploader:, disabled: false, association: :attachments)
    file_field = content_tag(:div, class: 'col-md-12') do
      content_tag(:div, class: 'form-group') do
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

    attachments_list = form.simple_fields_for :attachments do |pf|
      content_tag(:div, class: 'col-md-3') do
        file = pf&.object&.file
        image_url = image?(file) ? pf&.object&.file_url(:medium) : asset_path("file_types/#{extname(file)}.png")

        content_tag(:div, class: 'row') do
          image_part = content_tag(:div, class: 'col-md-12') do
            image_tag image_url, width: 128, title: filename(file), class: 'img-thumbnail'
          end

          desc_part = content_tag(:div, class: 'col-md-12') do

            content_tag(:div, class: 'row') do
              destroy_part = content_tag(:div, class: 'col-md-2') do
                pf.check_box :_destroy
              end

              label_part = content_tag(:div, class: 'col-md-10') do
                label_tag filename(file)
              end

              destroy_part + label_part
            end
          end

          desc_part + image_part
        end
      end
    end

    file_field + attachments_list
  end
end
