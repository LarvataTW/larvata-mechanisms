require "larvata/mechanisms/engine"

module Larvata
  module Mechanisms
    mattr_accessor :table_name_prefix
    @@table_name_prefix = nil
  end
end
