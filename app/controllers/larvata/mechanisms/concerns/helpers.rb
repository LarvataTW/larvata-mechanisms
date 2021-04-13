module Larvata::Mechanisms::Concerns::Helpers
  extend ActiveSupport::Concern

  included do
    # include all of Larvata::Mechanisms engine's helpers
    helper Larvata::Mechanisms::Engine.helpers
  end
end