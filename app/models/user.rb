class User < ApplicationRecord
	self.table_name = "users"

	# def self.authenticate(username,password)
	# 	where(user_name: username, password: password)
	# end

	scope :checking, -> (username) {
		where(user_name: username)
			
	}

	scope :get, -> (username) {
		where.not(user_name: username)
			
	}

	scope :authenticate, -> (username,password) {
		where(user_name: username, password: password)
	} 

	scope :adding, -> (username,password){
		record = User.new(user_name: username, password: password)
   		record.save
   }

   scope :findusername, ->(userid){
   		select(:user_name).where(id: userid)
   }

end
