class PokerTableController < ApplicationController
  def show
    @poker_table = PokerTable.find(params[:id])
  end
end
