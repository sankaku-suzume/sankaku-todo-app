class BoardsController < ApplicationController
  before_action :set_board, only:[:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @boards = Board.all
  end

  def show
    @tasks = @board.tasks
  end

  def new
    @board = current_user.boards.build
  end
  
  def create
    @board = current_user.boards.build(boards_params)
    if @board.save
      redirect_to board_path(@board), notice: 'Successfully saved.'
    else
      flash.now[:error] = 'Failed to save.'
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: 'Successfully deleted.'
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(boards_params)
      redirect_to board_path(@board), notice: 'Successfully updated.'
    else
      flash.now[:error] = 'Failed to update.'
      render :edit
    end
  end

  private
  def boards_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end

end