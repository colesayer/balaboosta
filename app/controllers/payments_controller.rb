class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def show
  end
end
