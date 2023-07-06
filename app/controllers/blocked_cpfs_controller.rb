# frozen_string_literal: true

class BlockedCpfsController < ApplicationController
  def index
    redirect_to new_blocked_cpf_path
  end

  def new
    @blocked_cpf = BlockedCpf.new
    @blocked_cpfs = BlockedCpf.all
  end

  def create
    @blocked_cpf = BlockedCpf.new(blocked_cpf_params)
    @blocked_cpf.blocked = true
    if @blocked_cpf.save
      redirect_to new_blocked_cpf_path, notice: 'CPF bloqueado com sucesso'
    else
      flash.now[:alert] = 'Houve um problema com esta requisição'
      render :new
    end
  end

  private

  def blocked_cpf_params
    params.require(:blocked_cpf).permit(:cpf, :blocked)
  end
end
