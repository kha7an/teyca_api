class OperationsController < ApplicationController
  def create
    result = Calculate.call(
      user_id: params[:user_id],
      positions: params[:positions]
    )
    return render_error(result) unless result.success?

    operation_result = CreateOperation.call(
      user_id: params[:user_id],
      check_summ: result.total_price,
      discount: result.total_discount,
      cashback: result.total_cashback
    )
    return render_error(operation_result) unless operation_result.success?

    render json: {
      status: 'success',
      operation_id: operation_result.operation_id,
      check_summ: result.total_price,
      discount: result.total_discount,
      cashback: result.total_cashback,
      discount_details: result.discount_details
    }
  end

  def confirm_operation
    result = ConfirmOperation.call(
      operation_id: params[:operation_id],
      write_off: params[:write_off]
    )
    return render_error(result) unless result.success?

    render json: {
      status: 'success',
      operation_id: params[:operation_id],
      cashback_earned: result.cashback_earned,
      final_price: result.final_price,
      written_off: params[:write_off]
    }
  end

  def render_error(result)
    render json: { status: 'error', message: result.message }, status: 400
  end
end
