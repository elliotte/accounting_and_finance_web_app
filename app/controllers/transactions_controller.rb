class TransactionsController < ApplicationController


  def edit 
  	@transaction = Transaction.find(params[:id])
  end

  def update
  	@transaction = Transaction.find(params[:id])
  	@transaction.update_attributes(edit_trn_params)
  end


  def edit_trn_params
  	params.require(:transaction).permit(:bank_description, :amount, :tax, :tb_mapping, :reconciled)
  end


end
