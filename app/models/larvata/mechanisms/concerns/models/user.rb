module Larvata::Mechanisms::Concerns::Models::User
  extend ActiveSupport::Concern

  included do
    has_many :user_roles, class_name: 'Larvata::Mechanisms::UserRole', dependent: :delete_all

    validates :name, length: { maximum: 255 }
    validates :email, presence: true, length: { maximum: 255 }
    validates :phone, length: { maximum: 255 }
  end
end