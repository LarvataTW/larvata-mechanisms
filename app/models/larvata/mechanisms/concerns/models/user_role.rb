module Larvata::Mechanisms::Concerns::Models::UserRole
  extend ActiveSupport::Concern

  included do
    belongs_to :role, class_name: 'Larvata::Mechanisms::Role', optional: true
    belongs_to :user, class_name: 'Larvata::Mechanisms::User', optional: true
  end
end