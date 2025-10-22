class User < ApplicationRecord
  # Devise-modulit ilman :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User
end
