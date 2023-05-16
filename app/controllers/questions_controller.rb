class QuestionsController < ApplicationController
  before_action :set_lot, only: [:create]

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

  private 

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

 
  def set_params 
    params.require(:question).permit(:lot_id, :user_id, :body)
  end
end