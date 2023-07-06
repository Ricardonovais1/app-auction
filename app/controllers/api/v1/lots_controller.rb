# frozen_string_literal: true

module Api
  module V1
    class LotsController < Api::V1::ApiController
      def show
        lot = Lot.find(params[:id])
        render status: 200, json: lot.as_json(except: %i[created_at updated_at])
      end

      def index
        lots = Lot.all.order(:code)
        render status: 200, json: lots
      end

      def create
        lot = Lot.new(lot_params)
        if lot.save
          render status: 201, json: lot
        else
          render status: 412, json: { errors: lot.errors.full_messages }
        end
      end

      def update
        lot = Lot.find(params[:id])
        if lot.update(lot_params)
          render status: 200, json: lot
        else
          render status: 412, json: { errors: lot.errors.full_messages }
        end
      end

      def destroy
        lot = Lot.find(params[:id])

        return unless lot.destroy

        render status: 200, json: { message: 'Lote deletado com sucesso' }
      end

      private

      def lot_params
        params.require(:lot).permit(:code,
                                    :start_date,
                                    :limit_date,
                                    :minimum_bid_value,
                                    :minimum_bid_difference,
                                    :by,
                                    :by_email,
                                    :status)
      end
    end
  end
end
