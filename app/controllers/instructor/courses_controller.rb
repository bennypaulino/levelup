class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    redirect_to instructor_course_path(@course)
  end

  def show
    @course = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])

    if @course.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @course.update_attributes(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def course_params
    params.require(:course).permit(:title, :description, :cost)
  end

end
