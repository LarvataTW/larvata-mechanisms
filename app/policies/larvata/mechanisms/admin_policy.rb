class Larvata::Mechanisms::AdminPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record.class == Array ? record[1] : record
  end

  def scope
    @record.default_scope
  end

  # 判斷當前使用者是否擁有指定功能或當前功能的使用權限
  # @param [nil] specific_func_name 指定功能
  # @return [TrueClass, FalseClass]
  def has_permission?(specific_func_name = nil)
    is_admin? or Larvata::Mechanisms::HasPermissionService.new(@user, specific_func_name || func_name).call
  end

  private

  def is_admin?
    @user.has_role?(:admin)
  end

  def func_name
    self.class.name.underscore.gsub('_policy', '')
  end
end

