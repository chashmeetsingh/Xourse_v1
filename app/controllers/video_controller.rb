class VideoController < ApplicationController

	def show
		@video = Video.find(params[:id])
	end

	def edit
		@video = Video.find(params[:id])
	end	

	def update
		video = Video.find(params[:id])
		video.update(:title=>params[:title],:url=>params[:url],:intro=>params[:intro],:length=>params[:length])
		length = video.course.length + params[:length].to_i
		video.course.update(:length=>length)
		if video.save
			flash[:notice] = "Video successfully updated!!"
		else
			flash[:notice] = video.errors.full_messages
		end
		redirect_to "/video/"+params[:id].to_s
	end

end
