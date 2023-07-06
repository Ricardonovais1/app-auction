# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @lots = Lot.all
    @current_lots = Lot.approved
    @future_lots = Lot.future
  end
end
