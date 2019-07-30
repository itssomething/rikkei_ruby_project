class User < ApplicationRecord
  has_many :test, dependent: :nullify

  has_secure_password
end
