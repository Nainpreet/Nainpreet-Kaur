#
class DepartmentsController < ApplicationController
  def index
    @search = Department.search(params[:q])
    @departments = @search.result.page params[:page]
  end

  def new
    authorize! :manage, :all
    @department = Department.new
  end

  def create
    authorize! :manage, :all
    @department = Department.create(dept_params)
    if @department.save
      flash[:success] = 'Successfully Added'
      redirect_to departments_path
    else
      render 'new'
    end
  end

  def edit
    authorize! :manage, :all
    @department = Department.find(params[:id])
  end

  def update
    authorize! :manage, :all
    @department = Department.find(params[:id])
    if @department.update_attributes(dept_params)
        redirect_to departments_path
    else
         render 'edit'
    end
  end

  def destroy
    authorize! :manage, :all
    @department = Department.find(params[:id])
    if @department.destroy
      redirect_to departments_path
    end
  end

  private

  def dept_params
    params.require(:department).permit(:name)
  end
end
