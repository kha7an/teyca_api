class Operation < ApplicationRecord
  belongs_to :user
  validates :check_summ, presence: true
end
