class TrialBalancesController < ApplicationController

  def create
    
    @TB_ids = []
    params[:data].each do |ledger_ID|
      _userTB = TrialBalance.new(guid_ledger: ledger_ID, guid_user: current_user.id)
      if _userTB.save 
        @TB_ids << _userTB.id
      else 
        redirect_to auth_dash_welcome_index_path, notice: "Something went wrong, please try again"
      end
    end

  end

end
