class LecturesController < ApplicationController

  before_action :authenticate_user!

  def new
  @lecture = Lecture.new(period: 2)
  @lecture.period = 1 if (Time.now.month < 5)
  @lecture.period = 3 if (Time.now.month > 8)
  @program  = params[:program]
  @semester = params[:semester]
      # esto esta horrible...
      if @program == nil
      @courses = Course.all
      elsif @semester == nil
      @courses = Course.where(:program => @program)
      else
      @courses = Course.where(:program => @program, :semester => @semester)
      end
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
    @lecture.generate_lecture_days
    redirect_to :back
  end

  def my_lectures
    @lectures = current_user.lectures
  end

  def my_reports
    @month_of_report = params[:month_of_report] || Date.today.to_report_month.to_s
    @period = params[:period] || Date.today.to_period.to_s
    @lectures = current_user.lectures.where(period: @period)
    @total_hours_of_class = @lectures.calculate_hours_per_month(@month_of_report)
  end

  private

  def lecture_params
    allow = [:course_id, :week_day, :lecture_start_time, :period, :year]
    params.require(:lecture).permit(allow)
  end

end
