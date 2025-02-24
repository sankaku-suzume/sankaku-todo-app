class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def create
    @board = current_user.boards.build(boards_params)
    @board.save
  end

  private
  def boards_params
    params.require(:board).permit(:title, :content)
  end

end