class BoardsController < ApplicationController
  before_action :set_board, only:[:show]


  def index
    @boards = Board.all
  end

  def show
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

  private
  def boards_params
    params.require(:board).permit(:title, :content)
  end

  def set_board
    @board = Board.find(params[:id])
  end

end