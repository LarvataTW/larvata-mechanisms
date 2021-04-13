module Larvata::Mechanisms::Inputs::Uploads::MimeTypesHelper
  private

  def mime_type(file)
    file&.metadata&.dig('mime_type')
  end

  def filename(file)
    file&.metadata&.dig('filename')
  end

  def image?(file)
    return true unless file # 未上傳檔案時，呈現預設圖片
    mime_type(file)&.start_with?('image')
  end

  def extname(file)
    filename(file) && File.extname(filename(file)).strip.downcase[1..-1]
  end
end
