class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  def show
    flash[:notice] = "请仔细阅读哦"
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "你没有访问权限！"
      redirect_to root_path
    end
  end
  def index
   flash[:notice] = "欢迎来到职缺的世界，总有一个适合你！"
    @jobs = case params[:order]
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC')
    when 'by_lower_bound'
      Job.published.order('wage_lower_bound DESC')
    else
    Job.published.recent
    end
  end
  def new
    @job = Job.new
  end
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end
  def edit
    @job = Job.find(params[:id])
  end
  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end
  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end
  private
  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end
end
