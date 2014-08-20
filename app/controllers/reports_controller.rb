class ReportsController < ApplicationController

   before_filter :authenticate_coordinator!, :except => [:create]
   before_filter :authenticate_user!, :only => [:create]


  def new
  end

  def create
    @report = current_user.reports.new(report_params)
    @report.save
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
      @users = User.turned_in_report(@month)
      @in_or_due = true
    else
      @users = User.still_owe_report(@month, @period)
    end
  end

  def download_report
    @report = Report.first
    render :xlsx => "download_report", :filename => "all_reports.xlsx"
  end

  private

  def report_params
    allow = [:year, :month_of_report, :total_hours]
    params.require(:report).permit(allow)
  end

end
  