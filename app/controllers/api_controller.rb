class ApiController < ApplicationController

	def create
		video = Video.create(:title=>params[:title],:course_id=>params[:course_id],:url=>params[:url],:length=>0)
		if video.save
			render text:"Added Successfully"
		else
			render text:"Could Not Be Added"
		end
	end

	def search
		@courses = Array.new
		list = Course.all
		list.each do |course|
			if course.course_name.downcase.include?(params[:keyword]) || course.language.downcase.include?(params[:keyword])
				@courses.push(course)
			end
		end
	end

	def like
		like = Like.create(:user_id=>session[:user_id],:video_id=>params[:video_id])
		course = Video.find_by(:id=>params[:video_id]).course
		course.likes+=1
		course.save
		if like.save
			render json: "Liked"
		else
			render json: "Error"
		end
	end

	def unlike
		course = Video.find_by(:id=>params[:video_id]).course
		course.likes-=1
		if course.likes < 0
			course.likes=0
		end
		course.save
		if Like.find_by(:user_id=>session[:user_id],:video_id=>params[:video_id]).destroy
			render json: "Unliked"
		else
			render json: "Error"
		end
	end

	def likecourse
		join = Join.create(:user_id=>session[:user_id],:course_id=>params[:course_id])
		if join.save 
			render json: "Joined"
		else
			render json: "Error"	
		end	
	end

	def unlikecourse
		if Join.find_by(:user_id=>session[:user_id],:course_id=>params[:course_id]).destroy
			render json "Unjoined"
		else
			render json: "Error"
		end
	end
end
