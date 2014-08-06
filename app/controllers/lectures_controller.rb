class LecturesController < ApplicationController

  before_action :authenticate_user!

  def new
  @lecture = Lecture.new(period: 2)
  @lecture.period = 1 if (Time.now.month < 5)
  @lecture.period = 3 if (Time.now.month > 8)
  end

  def edit
  end

  def destroy
  end

  def show
  end

  def create

    @lecture = current_user.lectures.new(lecture_params)
    @lecture.save
    # @report.add_days
    redirect_to :back

  end

  def my_lectures
    @lectures = current_user.lectures
  end



  private

  def lecture_params
    allow = [:course_id, :week_day, :lecture_start_time, :period]
    params.require(:lecture).permit(allow)
  end

end
