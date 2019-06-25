class ExampleController < ApplicationController
	#render json: {:code=>false,:message=>"Invalid Pincode"}.to_json
	 # @fname = "veera"
	 def create
	 	 @fname = 'veer'
	 	 @lname = 'mani'
	 	 @age = 21
	 	 #render partial: "create"
	 	 #render partial: "index", locals: {fname: 'veera'}
	  	#render json: {:code=>false,:message=>"Invalid Pincode #{@fname}"}.to_json
	 end
	 def create_form
	 	# byebug
	 	# puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>#{params[:firstname]}"
	 	if (params.has_key?(:firstname) && params.has_key?(:lastname))
	 		# puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		 	@fname = params[:firstname]
		 	@lname = params[:lastname]
		 	render "form_creation"
		else
			@fname = "firstname"
		 	@lname = "lastname"
			render "form_creation"
		end
	 	#render json: {:code=>false,:message=>"Invalid Pincode "}.to_json
	 end
end
