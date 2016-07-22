class TrialBalancesController < ApplicationController

  def create
      @tb_ids = []
      tb_stamp = SecureRandom.uuid
      params[:data].each do |ledger_id|
        _user_TB = TrialBalance.new(guid_ledger: ledger_id, guid_user: current_user.id, tb_uuid: tb_stamp )
        if _user_TB.save 
          @tb_ids << _user_TB.id
        else 
          redirect_to auth_dash_welcome_index_path, notice: "Something went wrong, please try again"
        end
      end
  end

  def index
    @user_generated_tbs = TrialBalance.where(guid_user: current_user.id)
    @data = @user_generated_tbs.select(:tb_uuid, :guid_ledger, :created_at).group_by(&:tb_uuid)
  end

  def view
    # needs to take params[:tb_uuid] via url
    # to be something like...
    # @data = TrialBalance.compile_data(params[:tag])
  end

end
