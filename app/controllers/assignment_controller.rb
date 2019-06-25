# require 'json'
require 'digest/md5'
class AssignmentController < ApplicationController
include AssignmentHelper
	
	def index
	end
	
	def create_login_form
		render "login_form"
	end
	
	def create_signup_form
		render "signup_form"
	end
	
	def create_signup_form
		render "signup_form"
	end

	def transaction
		@currid = User.checking(session[:username]).to_json
		@currid = JSON.parse @currid
		
		@check = User.get(session[:username]).to_json
		@check = JSON.parse @check

		@owedto = BalanceTracker.owedto(@currid[0]['id']).to_json
		@owedto = JSON.parse @owedto
		
		@owedfrom = BalanceTracker.owedfrom(@currid[0]['id']).to_json
		@owedfrom = JSON.parse @owedfrom
		
		@toamount = BalanceTracker.where(from_id: @currid[0]['id']).sum(:amount).to_i
		@fromamount = BalanceTracker.where(to_id: @currid[0]['id']).sum(:amount).to_i

		puts "??????????????????>>>>>>>>#{@toamount } "

		render "view_balance"
	end

	def transfer
		@check = BalanceTracker.checking(params['from'].to_i,params['to'].to_i).to_json
		@check = JSON.parse @check

		@checkfrom = BalanceTracker.checking(params['to'].to_i,params['from'].to_i).to_json
		@checkfrom = JSON.parse @checkfrom

		if(@checkfrom.length>0)
			addamt = @checkfrom[0]['amount'] - params['amount'].to_f
			if (addamt < 0)
				BalanceTracker.deletion(params['to'].to_i,params['from'].to_i)
				BalanceTracker.insert(params['from'].to_i,params['to'].to_i,addamt.to_f.abs)
				render json: {:code=>true,:message=>"Money Transferred and Updated"}.to_json
			elsif (addamt == 0)
				 BalanceTracker.deletion(params['to'].to_i,params['from'].to_i)
				 render json: {:code=>true,:message=>"Money Transferred and Updated"}.to_json
			else
				 BalanceTracker.updation(params['to'].to_i,params['from'].to_i,addamt.to_f)
				 render json: {:code=>true,:message=>"Money Transferred and Updated"}.to_json
			end
		else
			if (@check.length > 0)
				sum = @check[0]['amount'] + params['amount'].to_f
				BalanceTracker.updation(params['from'].to_i,params['to'].to_i,sum.to_f)
				render json: {:code=>true,:message=>"Money Transferred and Updated"}.to_json
			else
				BalanceTracker.insert(params['from'].to_i,params['to'].to_i,params['amount'].to_f)
				render json: {:code=>true,:message=>"Money Transferred"}.to_json
			end
		end
	end

	def repay
		@check = BalanceTracker.checking(params['to'].to_i,params['from'].to_i).to_json
		@check = JSON.parse @check
		
		if (@check.length > 0)
			diff = @check[0]['amount'] - params['amount'].to_f
			if(diff>0)
				BalanceTracker.updation(params['to'].to_i,params['from'].to_i,diff.to_f)
			 	render json: {:code=>true,:message=>"Transaction Successful"}.to_json
			 elsif(diff == 0)
			 	BalanceTracker.deletion(params['to'].to_i,params['from'].to_i)
			 	render json: {:code=>true,:message=>"Owed amount Completed"}.to_json
			 else
			 	diff = diff.abs
			 	BalanceTracker.deletion(params['to'].to_i,params['from'].to_i)
			 	BalanceTracker.insert(params['from'].to_i,params['to'].to_i,diff.to_f)
			 	render json: {:code=>false,:message=>"Owed amount Completed "}.to_json
			 end
		end
	end

	def authentication
		 puts "<<<<<<<<<<<<<<<<<<<<<<<<<#{params['username']}"
		 @check = User.checking(params['username']).to_json
		 @check = JSON.parse @check
		 hash_password = Digest::MD5.hexdigest(params['password']);

		 session[:username] = params['username']
		 session[:session_id] = @check[0]['id']
		 
		puts "ssssssssssssssssssssssss#{session[:session_id]},#{session[:user_name]}"
		 if (@check.length == 0 || (@check.length > 0 && @check[0]['password'] != hash_password))
		 	render json: {:code=>false,:message=>"invalid username or password"}.to_json
		 else
		 	Session.createrecord(session[:session_id],session[:username])
		 	puts "!!!!!!!!!!!!!!!!!#{@check[0]['user_name']}"
		 	render json: {:code=>true,:message=>"Login Successfully"}.to_json
		 end
	end

	def createnew
		 @check = User.find_by_user_name(params['susername']).to_json
		 @check = JSON.parse @check
	
		puts "??????????????????#{params['susername']},#{params['spassword']}"

		if @check.present?
			render json: {:code=>400,:message=>"existing user please login"}.to_json
		else
			hash_password = Digest::MD5.hexdigest(params['spassword']);
			User.adding(params['susername'],hash_password)
			render json: {:code=>200,:message=>"signup success"}.to_json
		end

	end

end
