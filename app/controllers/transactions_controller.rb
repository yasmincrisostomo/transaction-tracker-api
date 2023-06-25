class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
  end

  def transactions_within_date_range_for_product
    product = Product.find(params[:product_id])
    start_date = params[:start_date]
    end_date = params[:end_date]
    transactions = product.transactions.where("date >= ? AND date <= ?", start_date, end_date)
    render json: transactions
  end

  def upload_transactions_csv
    file = params[:file]
    if file.present?
      Transaction.upload_transactions_csv(file)
      render json: { message: "Transactions uploaded successfully" }, status: 200
    else
      render json: { message: "Please upload a file" }, status: 400
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:product_id, :quantity, :date)
  end
end
