module Larvata::Mechanisms::Concerns::Models::Permission
  extend ActiveSupport::Concern

  included do
    belongs_to :role, optional: true
    belongs_to :func, optional: true
  end
end