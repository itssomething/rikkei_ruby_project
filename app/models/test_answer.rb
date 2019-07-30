class TestAnswer < ApplicationRecord
  belongs_to :test
  belongs_to :question
end
