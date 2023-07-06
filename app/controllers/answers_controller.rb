# frozen_string_literal: true

class AnswersController < ApplicationController
  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
  end

  def create
    @lot = Lot.find(params[:lot_id])
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @lot, notice: 'Resposta enviada com sucesso'
    else
      flash[:alert] = 'Não foi possível enviar a resposta'
      render @lot
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:reply)
  end
end
