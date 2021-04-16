module Larvata::Mechanisms::Concerns::Models::UserRole
  extend ActiveSupport::Concern

  included do
    belongs_to :role, optional: true
    belongs_to :user, optional: true
  end
end