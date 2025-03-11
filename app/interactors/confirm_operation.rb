class ConfirmOperation
  include Interactor

  def call
    operation = Operation.find_by(id: context.operation_id)

    new_total = operation.check_summ - context.write_off.to_f
    cashback = (new_total * (operation.cashback_percent || 0) / 100).round(2)

    context.final_price = new_total
    context.cashback_earned = cashback
  end
end
