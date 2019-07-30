class Exam < ApplicationRecord
  belongs_to :category

  has_many :questions, dependent: :nullify
  has_many :tests, dependent: :nullify
  
  accepts_nested_attributes_for :questions, allow_destroy: true,
    reject_if: proc{|attributes| attributes["name"].blank?}
end
