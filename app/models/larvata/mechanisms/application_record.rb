module Larvata
  module Mechanisms
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
