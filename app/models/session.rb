class Session < ApplicationRecord
	self.table_name = 'sessions'
	
	scope :createrecord, -> (session_id,data){
		record = Session.new(session_id: session_id, data: data )
		record.save
   }
end
