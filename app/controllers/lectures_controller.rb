class LecturesController < ApplicationController


  before_action :authenticate_user!, :except => [:index, :my_reports]
  before_action :authenticate_coordinator!, :only => [:index]
  before_action :user_logged_in, :only => [:my_reports]

  def new
    @lecture = Lecture.new(period: 2)
    @lecture.period = 1 if (Time.now.month < 5)
    @lecture.period = 3 if (Time.now.month > 8)
    @program  = params[:program] || "Diseño Grafico"
    @semester = params[:semester] || "1"
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
    @lecture.update_lecture_days
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
  # El metodo period_to_report_month esta en config/initializers/integer.rb

  def my_reports
    @user = current_user || User.find(params[:id])
    @period          = params[:period] || Date.today.to_period.to_s
    @month_of_report = params[:month_of_report] || @period.to_i.period_to_report_month.to_s
    @lectures        = @user.lectures.where(period: @period)
    @total_hours_of_class = @lectures.calculate_hours_per_month(@month_of_report)
    @report = Report.new
    @holiday = false
  end

  private

  def lecture_params
    allow = [:course_id, :week_day, :lecture_start_time, :period, :year]
    params.require(:lecture).permit(allow)
  end

  def user_logged_in
    unless current_user || current_coordinator
      redirect_to root_path
    end
  end


end
