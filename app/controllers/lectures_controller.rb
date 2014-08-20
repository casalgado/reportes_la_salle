class LecturesController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def new
    @lecture = Lecture.new(period: 2)
    @lecture.period = 1 if (Time.now.month < 5)
    @lecture.period = 3 if (Time.now.month > 8)
    @program  = params[:program]
    @semester = params[:semester]
    @courses = Course.filter_courses(@program, @semester)
  end

  def create
    @lecture = current_user.lectures.new(lecture_params)
    @lecture.save
    @lecture.generate_lecture_days
    redirect_to :back
  end

  def index
    @program  = params[:program] || "Diseño Grafico"
    @semester = params[:semester]
    @period   = params[:period] || Date.today.to_period.to_s
      if @semester == nil
        @lectures = Lecture.per_period_program(@period, @program)
      else
        @lectures = Lecture.per_period_program_semester(@period, @program, @semester)
      end
  end

  def edit
    @lecture = Lecture.find(params[:id])
    @course = Course.find(@lecture.course_id)
  end

  def update
    @lecture = Lecture.find(params[:id])
    @lecture.update_attributes(lecture_params)
    @lecture.save
    redirect_to my_lectures_lecture_path
    
  end

  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy
    redirect_to my_lectures_lecture_path
  end

  def show
  end


  def my_lectures
    @lectures = current_user.lectures
  end

  # El metodo calculate_hours_per_month( ) esta declarado en config/initializers/array.rb

  def my_reports
    @month_of_report = params[:month_of_report] || Date.today.to_report_month.to_s
    @period          = params[:period] || Date.today.to_period.to_s
    @lectures        = current_user.lectures.where(period: @period)
    @total_hours_of_class = @lectures.calculate_hours_per_month(@month_of_report)
    @report = Report.new
  end

  private

  def lecture_params
    allow = [:course_id, :week_day, :lecture_start_time, :period, :year]
    params.require(:lecture).permit(allow)
  end



end
