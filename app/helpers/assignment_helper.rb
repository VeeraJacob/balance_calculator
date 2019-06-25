
module AssignmentHelper
	def transaction_history( result )
		@user_name = User.findusername(result).to_json
		@user_name = JSON.parse @user_name
		# return
	end

	def borrow_money_details(id)
		@curruser = User.where(id: id)
	end

end
