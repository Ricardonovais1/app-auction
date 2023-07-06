# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_lot, only: %i[create hidden visible block_by_cpf]

  def hidden
    @question = Question.find(params[:id])
    @question.hidden!
    redirect_to @question.lot, notice: 'Pergunta ocultada com sucesso'
  end

  def visible
    @question = Question.find(params[:id])
    @question.visible!
    redirect_to @question.lot
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(set_params)
    @question.lot_id = params[:lot_id]
    @question.user_id = current_user.id

    if @question.save
      redirect_to @lot, notice: 'Sua pergunta foi enviada com sucesso'
    else
      flash[:alert] = 'Mensagem muito curta...'
      redirect_to @lot
    end
  end

  def block_by_cpf
    cpf = current_user.registration_number if user_signed_in?

    if BlockedCpf.where(cpf:, blocked: true).exists?
      flash[:alert] = 'CPF bloqueado. Mensagens não permitidas'
      redirect_to lot_path(@lot)
    else
      @question = Question.new(set_params)
      @question.lot_id = params[:lot_id]
      @question.user_id = current_user.id

      if @question.save
        redirect_to @lot, notice: 'Sua pergunta foi enviada com sucesso'
      else
        flash[:alert] = 'Mensagem muito curta...'
        redirect_to @lot
      end
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def set_params
    params.require(:question).permit(:body, :visibility)
  end
end
