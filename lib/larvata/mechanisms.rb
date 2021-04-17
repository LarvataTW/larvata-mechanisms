require "larvata/mechanisms/engine"

module Larvata
  module Mechanisms
    mattr_accessor :table_name_prefix
    @@table_name_prefix = nil

    mattr_accessor :association_between_user_and_role
    @@association_between_user_and_role = 'users_roles'
  end
end
