module Larvata::Mechanisms::Inputs::Uploads::ServerHelper
  def upload_server
    Rails.configuration.upload_server
  end
end