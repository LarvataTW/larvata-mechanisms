class Larvata::Mechanisms::HasPermissionService
  def initialize(user = nil, func_name = nil)
    @user = user
    @func_name = func_name
  end

  def call
    Func.joins(:permissions)
        .where(name: @func_name)
        .where(Permission.table_name => {role_id: role_ids})
        .any?
  end

  private

  def role_ids
    @user&.roles.pluck(:id)
  end
end