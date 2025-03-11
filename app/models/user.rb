class User < ApplicationRecord
  belongs_to :template, foreign_key: "template_id"
  has_many :operations
end
