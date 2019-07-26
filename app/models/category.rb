class Category < ApplicationRecord
  has_many :exams, dependent: :nullify
end
