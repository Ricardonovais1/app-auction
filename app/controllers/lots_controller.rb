class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :approved, :pending_approval]
  before_action :authenticate_user!, only: [:new, :expired, :pending]
  before_action :check_admin_user, only: [:new, :expired, :pending]

  def expired 
    @expired_lots = Lot.expired
    @lots = Lot.all
  end 

  def pending 
    @pending_lots = Lot.pending_approval
    @lots = Lot.all
  end

  def new 
    @lot = Lot.new
  end

  def create 
    @lot = Lot.new(set_params)
    @lot.by = current_user.name
    @lot.by_email = current_user.email
    if @lot.save
      redirect_to @lot, notice: "Lote cadastrado com sucesso" 
    else  
      flash.now[:alert] = 'Houve um erro ao cadastrar o lote'
      render :new
    end
  end

  def show
  end

  def approved 
    @lot.approved!
    redirect_to @lot
  end

  def pending_approval 
    @lot.pending_approval!
    redirect_to @lot
  end

  private 

  def set_lot 
    @lot = Lot.find(params[:id])
  end

  def set_params
    params.require(:lot).permit(:code, 
                                :start_date, 
                                :limit_date, 
                                :minimum_bid_value, 
                                :minimum_bid_difference, 
                                :by, 
                                :by_email,
                                :status)
  end

  def check_admin_user
    unless current_user.admin?
      redirect_to root_path, alert: 'Você não tem permissão para acessar esta página'
    end
  end
end