class Category < ApplicationRecord
  has_many :exams, -> {order(name: :asc)}, dependent: :nullify
end
