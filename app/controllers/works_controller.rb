class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, except: [:show, :index]

  def my_desk
    @works = current_user.works.all
  end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
  end

  def edit
  end

  def update
    if @work.update_attributes(work_params)
      current_user.works << @work unless current_user.works.include? @work
      redirect_to @work, notice: 'Work was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      current_user.works << @work
      flash[:notice] = 'Work was successfully created.'
      redirect_to @work
    else
      flash.now[:error] = 'Work could not be saved.'
      render :new
    end
  end

  def destroy
    @work.destroy
    redirect_to root_path, notice: 'Work was successfully deleted.'
  end

  private

  def set_work
    @work = Work.find(params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :body)
  end
end
