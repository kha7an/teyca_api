class Calculate
  include Interactor

  def call
    user = User.includes(:template).find_by(id: context.user_id)

    total_price = 0
    total_discount = 0
    total_cashback = 0
    discount_details = []

    context.positions.each do |position|
      product = Product.find_by(id: position[:id])

      item_total = position[:price] * position[:quantity]
      discount, cashback = calculate_discounts(user, product, item_total)

      total_price += item_total - discount
      total_discount += discount
      total_cashback += cashback

      discount_details << {
        id: position[:id],
        discount: discount,
        cashback: cashback
      }
    end

    context.total_price = total_price
    context.total_discount = total_discount
    context.total_cashback = total_cashback
    context.discount_details = discount_details
  end

  private

  def calculate_discounts(user, product, item_total)
    discount = 0
    cashback = 0

    case user.template.name
    when 'Bronze'
      cashback += item_total * 0.05
    when 'Silver'
      discount += item_total * 0.10
      cashback += item_total * 0.03
    when 'Gold'
      discount += item_total * 0.15
    end

    discount += item_total * 0.05 if product.discount?
    cashback += item_total * 0.05 if product.increased_cashback?

    if product.noloyalty?
      discount = 0
      cashback = 0
    end

    [discount.round(2), cashback.round(2)]
  end
end
