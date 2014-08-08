class LectureDaysController < ApplicationController
  


  def edit
  	@lecture_day = LectureDay.find(params[:format])
  end

  def update
  	@lecture_day = LectureDay.find(params[:id])
  	@lecture_day.update_attributes(lecture_day_params)
  	@lecture_day.save
  	@lecture_day.update_report_month
  	redirect_to my_reports_lecture_path(current_user)
  	
  end

  def destroy
  end

  private

  def lecture_day_params
    allow = [:date_of_lecture, :time_of_lecture]
    params.require(:lecture_day).permit(allow)
  end

end
