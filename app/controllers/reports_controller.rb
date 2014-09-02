class ReportsController < ApplicationController

   before_filter :authenticate_coordinator!, :except => [:create, :download_report]
   before_filter :authenticate_user!, :only => [:create]


  def new
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
       @lecture_days = LectureDay.update_report_id(@report.year, @report.period, @report.month_of_report, current_user.id, @report.id)
       flash[:notice] = "Reporte ha sido Enviado"
       redirect_to my_reports_lecture_path(:id => current_user.id, :period => @report.period, :month_of_report => @report.month_of_report)
     end
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
      render :xlsx => "download_report", :filename => "#{Date.new(2001, @report.month_of_report, 12).strftime('%b')} - #{@report.user.first_name[0]}#{@report.user.last_name}.xlsx"
  end


  private

  def report_params
    allow = [:year, :month_of_report, :total_hours]
    params.require(:report).permit(allow)
  end

end

  # def download_report
  #   compressed_filestream = Zip::ZipOutputStream.write_buffer do |zos|
  #     params[:user_id].each do |user_id|
  #       @report = Report.find_by(:user_id => user_id, :month_of_report => params[:month_of_report])
  #       @lecture_days = @report.lecture_days
  #       content = render_to_string :xlsx => "download_report", :filename => "#{Date.new(2001, @report.month_of_report, 12).strftime('%b')} - #{@report.user.first_name[0]}#{@report.user.last_name}.xlsx"
  #       zos.put_next_entry("user_#{user_id}.xlsx")
  #       zos.print content
  #     end
  #   end
  #  compressed_filestream.rewind
  #  send_data compressed_filestream.read, :filename => 'download_report.zip', :type => "application/zip"
  # end





  