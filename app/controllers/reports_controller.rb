class ReportsController < ApplicationController

   before_action :authenticate_coordinator!, :except => [:create]
   before_filter :authenticate_user!, :only => [:create]


  def new
  end

  def edit
  end

  def create
    @report = current_user.reports.new(report_params)
    @report.save
    redirect_to :back
  end

  def update
  end

  def show
  end

  def index
    @month_of_report = params[:month_of_report] || Date.today.to_report_month.to_s
    @period = params[:period] || Date.today.to_period.to_s
    @reports = Report.all
    @reports_turned_in = Report.where(year: Date.today.year.to_i, month_of_report: @month_of_report).count
    @total_reports_due = Lecture.where(year: Date.today.year.to_i, period: @period).count
    @reports_still_due = @total_reports_due - @reports_turned_in

  end

  def destroy
  end

  private

  def report_params
    allow = [:year, :month_of_report, :total_hours]
    params.require(:report).permit(allow)
    
  end

end
