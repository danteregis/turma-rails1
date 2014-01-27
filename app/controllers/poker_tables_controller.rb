class PokerTablesController < ApplicationController
  
  def index
    @poker_tables = PokerTable.order(:name).all
  end
  
  def new
    @poker_table = PokerTable.new
  end
  
  def create
    @poker_table = PokerTable.create(poker_table_params)
    if @poker_table.persisted?
      redirect_to poker_tables_path, notice: "Mesa criada com sucesso"
    else
      render :new
    end
  end
  
  def edit
    @poker_table = PokerTable.find(params[:id])
  end
  
  def update
    @poker_table = PokerTable.find(params[:id])
    if @poker_table.update(poker_table_params)
      redirect_to poker_tables_path, notice: "Tudo OK!"
    else
      flash[:error] = "Erro ao editar"
      render :edit
    end
  end
  
  
  def show
  end
  
  
  private
  def poker_table_params
    params.require(:poker_table).permit(:big_blind, :small_blind, :name)
  end
  
end
