class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update]

def show; end

def edit; end  

def update  
  byebug
  
  if @user.update(user_params)
    redirect_to @user, notice: 'Dados atualizados com sucesso'
  else
    render 'edit'
  end
end

private 

def set_user 
  @user = User.find(params[:id])
end

def user_params 
  params.require(:user).permit(:name, :email, :registration_number, :about)
end
end