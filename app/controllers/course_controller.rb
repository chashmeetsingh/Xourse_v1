class CourseController < ApplicationController

	def new
	end

	def create
		course = Course.create(course_params)
	    course.length = 0
	    course.views = 0
	    course.rating = 0
	    course.likes = 0
	  	if course.save
	      flash[:notice] = "Course Added successfully !"
	      redirect_to('/index')
	  	else
	  		flash[:notice] = course.errors.full_messages
	  		redirect_to(:action=>'new')
	  	end	
	end

	def show
		@course = Course.find_by(:course_name=>params[:course_name])
		video = Video.where(:course_id=>@course.id)
		length=0
		video.each do |v|
			length += v.length
		end
		view = @course.views + 1
		@course.update(:length => length, :views=>view) 
		@videos = Video.where(:course_id=>Course.find_by(:course_name=>params[:course_name]))
	end

	private

	def course_params
		params.require(:course).permit(:course_name,:language,:level,:provider,:intro)
	end
end
