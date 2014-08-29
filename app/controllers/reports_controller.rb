class ReportsController < ApplicationController

   before_filter :authenticate_coordinator!, :except => [:create, :download_report]
   before_filter :authenticate_user!, :only => [:create]


  def new
  end

  def create
    @report = current_user.reports.new(report_params)
    @report.save
    @lecture_days = LectureDay.update_report_id(@report.year, @report.period, @report.month_of_report, current_user.id, @report.id)
    redirect_to :back
  end

  def index
    @month_of_report = params[:month_of_report] || Date.today.to_report_month.to_s
    @period  = params[:period] || Date.today.to_period.to_s
    @reports = Report.all
    @reports_turned_in = Report.reports_turned_in_count(@month_of_report)
    @total_reports_due = User.per_period(@period).uniq.count
    @reports_still_due = @total_reports_due - @reports_turned_in
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def reports_list
    @month  = params[:month_of_report]
    @period = params[:period]
    if params[:in_or_due]
      @users = User.turned_in_report(@month).sort_by { |u| u.last_name }
      @in_or_due = true
    else
      @users = User.still_owe_report(@month, @period).sort.sort_by { |u| u.last_name }
    end
  end

  def download_report
      @report = Report.find_by(:user_id => params[:user_id], :month_of_report => params[:month_of_report])
      @lecture_days = @report.lecture_days
      render :xlsx => "download_report", :filename => "#{Date.new(2001, @report.month_of_report, 12).strftime('%b')} - #{@report.user.last_name}.xlsx"
  end


  private

  def report_params
    allow = [:year, :month_of_report, :total_hours]
    params.require(:report).permit(allow)
  end

end
  