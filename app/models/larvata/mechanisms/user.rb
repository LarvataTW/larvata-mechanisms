module Larvata::Mechanisms
  class User < ApplicationRecord
    include Larvata::Mechanisms::Concerns::Models::User
    self.table_name = "#{Larvata::Mechanisms.table_name_prefix.to_s}users"

    rolify :role_cname => 'Larvata::Mechanisms::Role', :role_join_table_name => 'users_roles'

    # Include default devise modules. Others available are:
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable, :trackable
  end
end
