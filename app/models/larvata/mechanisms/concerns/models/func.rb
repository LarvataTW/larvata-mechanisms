module Larvata::Mechanisms::Concerns::Models::Func
  extend ActiveSupport::Concern

  included do
    has_many :permissions, class_name: 'Larvata::Mechanisms::Permission', dependent: :destroy
    has_many :roles, class_name: 'Larvata::Mechanisms::Role', through: :permissions
  end
end