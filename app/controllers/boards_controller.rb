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
      redirect_to board_path(@board), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
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