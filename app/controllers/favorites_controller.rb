# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(favorite_params)
    @lot = Lot.find(params[:lot_id])
    @favorite.save
    redirect_to lot_path(@lot), notice: "Lote #{@lot.code} adicionado aos favoritos"
  end

  def destroy
    @lot = Lot.find(params[:lot_id])
    @favorite = current_user.favorites.where('lot_id = ?', @lot.id).first
    if @favorite.destroy!
      current_user.favorites.delete(@favorite)
      redirect_to request.referer, notice: "Lote #{@lot.code} removido dos favoritos"
    else
      redirect_to request.referer, alert: 'Não foi possível remover este lote dos favoritos'
    end
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params.permit(:user_id, :lot_id)
  end
end
