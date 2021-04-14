module Larvata::Mechanisms::Concerns::Helpers
  extend ActiveSupport::Concern

  included do
    # include all of Larvata::Mechanisms engine's helpers
    helper Larvata::Mechanisms::Engine.helpers

    layout :set_layout

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    # 處理沒有通過認證時的情況
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore.gsub('/', '.')
      flash[:error] = t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)

      redirect_to(request.referrer || admin_root_path)
    end

    # 檢查是否有權限進行操作
    def authorize_by_pundit(record = nil)
      policy_class = self.class.name.gsub('Controller', 'Policy').constantize
      authorize record, policy_class: policy_class
    end

    # 主要提供在執行 open_modal 機制時，modal 頁面內容可以不使用預設的 admin layout。
    def set_layout
      params&.dig(:layout) || default_layout
    end

    def default_layout
      _layout = self.class.name.deconstantize.split('::').first || 'application'
      _layout.downcase
    end
  end
end