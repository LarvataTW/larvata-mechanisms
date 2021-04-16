module Larvata::Mechanisms
  class Attachment < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::Attachment
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}attachments"
  end
end
