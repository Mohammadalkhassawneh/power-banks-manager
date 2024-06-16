class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  enum role: { user: 'user', admin: 'admin' }

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: roles.keys }

  before_create :generate_jti

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end
