module Larvata::Mechanisms::Concerns::Models::User
  extend ActiveSupport::Concern

  included do
    has_many :user_roles, class_name: 'Larvata::Mechanism::UserRole', dependent: :destroy
    has_many :permissions, class_name: 'Larvata::Mechanisms::Permission', dependent: :destroy

    validates :name, length: { maximum: 255 }
    validates :email, presence: true, length: { maximum: 255 }
    validates :phone, length: { maximum: 255 }
  end
end