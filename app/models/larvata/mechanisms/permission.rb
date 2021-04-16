module Larvata::Mechanisms
  class Permission < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::Permission
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}permissions"
  end
end
