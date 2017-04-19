#
class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(dept_params)
    if @department.save
      flash[:success] = "Successfully Added"
      redirect_to departments_path
    else
      render 'new'
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(dept_params)
        redirect_to departments_path
    else
         render 'edit'
    end
  end

  def destroy
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
