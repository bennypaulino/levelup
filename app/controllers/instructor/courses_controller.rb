class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :require_authorized_for_current_course, only: [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
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

  def destroy
    @course = Course.find(params[:id])
    if @course.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @course.destroy
    redirect_to root_path
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end

end
