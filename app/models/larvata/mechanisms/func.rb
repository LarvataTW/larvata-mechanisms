module Larvata::Mechanisms
  class Func < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::Func
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}funcs"
  end
end
