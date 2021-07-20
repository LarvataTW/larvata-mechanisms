module Larvata::Mechanisms::Inputs::FileHelper
  # form: 表單物件
  # uploader: 要使用的 Uploader 物件
  # model: 表單資料實例物件
  # label: 欄位說明
  # field_name: 欄位名稱
  # preview_thumbnail: 縮圖類型
  # preview_width: 縮圖寬度
  # disabled: 是否禁用，預設為 false
  def file_tag(form:, uploader:, model:, label:, field_name:, preview_thumbnail:, preview_height:, preview_width:, preview_placeholder:, disabled: false)
    file = model.send("#{field_name.to_s}")
    filename = file&.metadata&.dig('filename')
    file_thumbnail_url = image?(file) ? file_preview_url(model, field_name, preview_thumbnail) : "larvata/mechanisms/file_types/#{extname(file)}.png"

    preview_thumbnail_url = file_thumbnail_url.presence || "https://fakeimg.pl/#{preview_width}x#{preview_height}/?text=#{preview_placeholder}&font=noto"

    file_field_content = content_tag(:div, class: 'form-group') do
      file_field = form.file_field field_name.to_s,
                                   class: 'uppy-choose', disabled: disabled,
                                   accept: defined?(uploader::ALLOWED_TYPES) ? uploader::ALLOWED_TYPES.join(",") : nil,
                                   data: {
                                     label: label,
                                     upload_server: upload_server,
                                     preview_element: "preview-#{field_name.to_s}",
                                     upload_result_element: "album-#{field_name.to_s}",
                                     restrictions: {
                                       maxFileSize: defined?(uploader::MAX_SIZE) ? uploader::MAX_SIZE : nil,
                                       minFileSize: defined?(uploader::MIN_SIZE) ? uploader::MIN_SIZE : nil,
                                       maxTotalFileSize: defined?(uploader::MAX_TOTAL_SIZE) ? uploader::MAX_TOTAL_SIZE : nil,
                                       maxNumberOfFiles: defined?(uploader::MAX_NUMBER) ? uploader::MAX_NUMBER : nil,
                                       minNumberOfFiles: defined?(uploader::MIN_NUMBER) ? uploader::MIN_NUMBER : nil,
                                       allowedFileTypes: defined?(uploader::ALLOWED_TYPES) ? uploader::ALLOWED_TYPES.join(",") : nil,
                                     },
                                   }

      hidden_field = form.hidden_field field_name, id: "album-#{field_name.to_s}", value: model.send("cached_#{field_name.to_s}_data")

      file_field + hidden_field
    end

    image_preview = content_tag(:div, class: 'row') do
      filename_part = content_tag(:div, class: 'col-md-12') do
        filename
      end

      image_tag_part = content_tag(:div, class: 'col-md-12 image-preview') do
        image_tag preview_thumbnail_url,
                  height: image?(file) ? preview_height : 128,
                  width: image?(file) ? preview_width : 128,
                  class: "img-thumbnail file-upload-preview",
                  id: "preview-#{field_name.to_s}"
      end

      image_tag_part + filename_part
    end

    file_field_content + image_preview
  end

  private

  def file_preview_url(object, field_name, preview_thumbnail)
    preview_thumbnail ? object&.send("#{field_name}_url", preview_thumbnail) : object&.send("#{field_name}_url")
  end
end
