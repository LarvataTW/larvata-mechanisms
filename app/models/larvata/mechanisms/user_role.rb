module Larvata::Mechanisms
  class UserRole < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::UserRole
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}#{Larvata::Mechanisms.association_between_user_and_role}"
  end
end
