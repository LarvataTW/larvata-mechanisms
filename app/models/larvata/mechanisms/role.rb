module Larvata::Mechanisms
  class Role < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::Role
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}roles"
  end
end
