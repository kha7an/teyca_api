class CreateOperation
  include Interactor

  def call
    user = User.find_by(id: context.user_id)

    operation = Operation.create!(
      user: user,
      check_summ: context.check_summ,
      discount: context.discount,
      cashback: context.cashback,
      cashback_percent: context.check_summ > 0 ? (context.cashback / context.check_summ * 100) : 0,
      discount_percent: context.check_summ > 0 ? (context.discount / context.check_summ * 100) : 0

    )

    context.operation_id = operation.id
  end
end
