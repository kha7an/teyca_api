class Product < ApplicationRecord
  self.inheritance_column = nil # рельсы будут игнорировать Type(слово зарезервировано)

  def discount?
    type == "discount"
  end

  def increased_cashback?
    type == "increased_cashback"
  end

  def noloyalty?
    type == "noloyalty"
  end
end
