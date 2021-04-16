module Larvata::Mechanisms::Concerns::Models::Role
  extend ActiveSupport::Concern

  included do
    # 固定角色：系統管理員
    # 不可刪除
    DEFAULT_ROLES = %w(admin)

    has_many :permissions, class_name: 'Larvata::Mechanisms::Permission', dependent: :destroy
    has_many :funcs, class_name: 'Larvata::Mechanisms::Func', through: :permissions
    has_many :user_roles, class_name: 'Larvata::Mechanisms::UserRole', dependent: :destroy
    has_many :users, class_name: 'Larvata::Mechanisms::User', through: :user_roles

    validates :name, :desc, length: { maximum: 255 }
    validates :name, presence: true

    def can_be_destroyed?
      not default? and not assigned?
    end

    def default?
      Role::DEFAULT_ROLES.include?(name)
    end

    def assigned?
      table = "users_roles"
      ActiveRecord::Base.connection.instance_variable_get('@connection')
                        .query("select exists(select 1 from #{table} where role_id = #{id}) as result", as: :hash)
                        .first&.dig('result') == 1
    end
  end
end