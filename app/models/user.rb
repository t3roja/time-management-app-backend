class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  def admin?
    admin
  end

  has_many :projects, dependent: :destroy
end
