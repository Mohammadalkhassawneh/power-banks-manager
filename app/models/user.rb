class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  enum role: { user: 'user', admin: 'admin' }

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: roles.keys }
end
