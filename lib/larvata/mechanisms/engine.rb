module Larvata
  module Mechanisms
    class Engine < ::Rails::Engine
      require 'devise'
      require 'rolify'

      isolate_namespace Larvata::Mechanisms
    end
  end
end
