class LectureDaysController < ApplicationController
  
  before_action :authenticate_user!

  def edit
  	@lecture_day = current_user.lecture_days.find_by_id(params[:id])
    redirect_to root_path unless Report.exists_for?(current_user.id, @lecture_day)
    redirect_to root_path, :flash => { :error => "Insufficient rights!" } unless(@lecture_day)
  end

  def update
  	@lecture_day = current_user.lecture_days.find(params[:id])
    if Report.exists_for?(current_user.id, @lecture_day)
  	 @lecture_day.update_attributes(lecture_day_params)
  	 @lecture_day.save
  	 @lecture_day.update_report_month
     return redirect_to my_reports_lecture_path(current_user)
    else
     return redirect_to :back
    end
  	 
  	
  end

  def destroy
  end

  private

  def lecture_day_params
    allow = [:date_of_lecture, :time_of_lecture]
    params.require(:lecture_day).permit(allow)
  end

end
