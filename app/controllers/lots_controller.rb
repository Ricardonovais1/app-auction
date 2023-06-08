class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :approved, :pending_approval, :remove, :edit, :update, :bid_on_lot]
  before_action :authenticate_user!, only: [:new, :expired, :pending, :successfull_bids, :edit]
  before_action :check_admin_user, only: [:new, :expired, :pending, :edit]

  def index 
    redirect_to new_lot_path
  end 

  def successfull_bids
    @expired_lots = Lot.expired
  end

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
    @lot_item = LotItem.new
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

  def bid_on_lot
    cpf = current_user.registration_number if user_signed_in?

    if BlockedCpf.where(cpf: cpf, blocked: true).exists?
      flash[:alert] = "CPF bloqueado. Lance não permitido"
      redirect_to lot_path(params[:id])
    else
      redirect_to new_lot_bid_path(@lot)
    end
  end

  def show
    @lot = Lot.find(params[:id])
    @expired_lots = Lot.expired
    @question = Question.new
    @questions = @lot.questions
  end

  def approved 
    @lot.approved_by = current_user.name
    @lot.approved_by_email = current_user.email
    @lot.approved!
    redirect_to @lot
  end

  def pending_approval 
    @lot.pending_approval!
    redirect_to @lot
  end

  def remove 
    @lot_item = @lot.lot_items.find(params[:id])
  end

  def edit; end

  def update 
    if @lot.update(set_params)
      redirect_to @lot, notice: 'Lote atualizado com sucesso'
    else  
      flash.now[:alert] = 'Houve um problema ao atualizar o lote'
      render "edit"
    end
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