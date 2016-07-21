class LedgersController < ApplicationController

  before_action :find_ledger, except: [:index, :new, :create, :create_tb_form, :generate_user_tb]

  def index
    @ledgers = current_user.ledgers.order('created_at DESC')
  end

  def new
     @ledger = current_user.ledgers.new
     respond_to do |format|
       format.js
     end
  end

  def create
	  @ledger = current_user.ledgers.create(ledger_params)
	  if @ledger.save
	    redirect_to ledger_path(@ledger), notice: "Ledger successfully added"
	  else
	    redirect_to ledgers_path, notice: "Something went wrong, try again"
	  end
  end

  def import_trns; end

  def persist_csv_trns 
    input = AppImportService.new(@ledger, params[:file].tempfile)
    begin
      input.write_to_db
      redirect_to ledger_path(@ledger), notice: "Transactions imported successfully"
    rescue
      redirect_to ledger_path(@ledger), notice: "WoW | Error reported - check your input file"
    end
  end

  def show; end

  def reconcile_transactions
    @transactions = @ledger.transactions.order("acc_date DESC")
  end

  def create_tb_form
    @ledger_details = current_user.ledgers.select('id, user_tag, title').limit(10)
  end

  def ledger_params
     params.require(:ledger).permit(:user_tag, :title, :type, :opening_balance) unless params[:ledger].blank?
  end

  def find_ledger
  	 @ledger = Ledger.find(params[:id])
  end

end
