class BalanceTracker < ApplicationRecord

	self.table_name = "balance_trackers"
   
	scope :owedto, ->(userid){
		where(from_id: userid)
	}

	scope :owedfrom, ->(userid){
		where(to_id: userid)
	}

	scope :insert, -> (from_id,to_id,amount){
		record = BalanceTracker.new(from_id: from_id, to_id: to_id, amount: amount)
   	record.save
   }

   scope :checking, ->(from_id,to_id){
   		where(from_id: from_id, to_id: to_id)
   }

   scope :updation, ->(from_id,to_id,amount){
   		where(from_id: from_id, to_id: to_id).limit(1).update_all(amount: amount)
   }

   scope :deletion, ->(from_id,to_id){
   		where(from_id: from_id, to_id: to_id).limit(1).destroy_all
   }


end
