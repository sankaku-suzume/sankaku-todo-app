class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @task = Task.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: 'Task added.'
    else
      flash.now[:error] = 'Failed to add task.'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@task.board_id, @task.id), notice: 'Successfully updated.'
    else
      flash.now[:error] = 'Failed to update.'
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(
      :name,
      :description,
      :due,
      :eyecatch
    ).
    merge(
      user_id: current_user.id
    )
  end

end