
$(document).ready(function(){

	$("#loginbut").click(function(e){
		//alert("testing...");
		var username = $("#username").val();
		var password = $("#password").val();
		var params = "";

		if(username == "" || password == "")
		{
			alert("Please fill username and password");
			username = "";
			password = "";
			return false;
		}
		else
		{
			params += '&' + 'username' + '=' + username;
			params += '&' + 'password' + '=' + password;
			$.ajax({
				type: "POST",
				url: "/assignment/login",
				data: params,
				success: function(result){
					//window.location.href = "/assignment/signup"
					if(result.code == true)
					{
						alert(result.message);
						window.location.href = "/assignment/transaction";
					}
					else
					{
						alert(result.message);
						window.location.href = "/assignment/login";
					}
					//return true;
				}
				

			});
			
		}
		e.stopImmediatePropagation();
		return false;
		//alert("hi")
	});

	$("#signupbut").click(function(){
		//alert("ji");
		var username = $("#susername").val();
		var password = $("#spassword").val();
		var params = "";
		//alert(password);
		if(username == "" || password == "")
		{
			alert("Please fill username and password");
			username = "";
			
			password = "";
			return false;
		}
		else
		{
			params += '&' + 'susername' + '=' + $("#susername").val();
			params += '&' + 'spassword' + '=' + $("#spassword").val();
			$.ajax({
				type: "POST",
				url: "/assignment/createrow",
				data: params,
				success: function(result){
					//window.location.href = "/assignment/signup"
					//alert(result);
					if(result.code == 200)
					{
						alert(result.message);
						window.location.href = "/assignment/transaction";
					}
					else
					{
						alert(result.message);
						window.location.href = "/assignment/signup";
					}
				}
			}).fail(function(xhr, textStatus, errorThrown){
       				alert('request failed');
  				})
		}

	});

	$("#owedto").click(function(){

		$("#totoggle").css({top: 500, left: 490});
		$("#totoggle").css("position","absolute");		
		$("#totoggle").toggle();
		$("#fromtoggle").css("display","none");


	});

	$("#owedfrom").click(function(){

		$("#fromtoggle").css({top: 500, left: 490});
		$("#fromtoggle").css("position","absolute");		
		$("#fromtoggle").toggle();
		$("#totoggle").css("display","none");

	});

	
	$("#transfer").css("position","absolute");
	$("#transfer").css({top: 30, left: 400});

	$("#title").css("position","absolute");
	$("#title").css({top: 10, left: 510});

    $("#toselect").css("display","none");
    $("#fromselect").css("display","none");	


	$("#tofrom").on('change',function(){
		var type = $("#tofrom option:selected").text();
		//alert(type);
		if(type == 'owedfrom')
		{
			$("#toselect").css("display","none");
			$("#fromselect").show();
			$("#dummy").hide();
		}
		else if(type == 'owedto')
		{
			$("#fromselect").css("display","none");
			$("#toselect").show();
			$("#dummy").hide();	
		}
		else
		{
			$("#toselect").css("display","none");
			$("#fromselect").css("display","none");
			$("#dummy").show();
		}
	});

	$("#logout").click(function(){
		// $.cookie("name", null);
		//sessionStorage.clear();
		window.location.href = "/assignment/login"
	})

	$("#send").click(function(){
		var type = $("#tofrom option:selected").text();
		//var to = $("#toselect option:selected").text();
		var amount = $("#amount").val();
		var params = "";
		//alert(amount);
		//alert(type);
		if(type == 'select'|| $("#amount").val()=="")
		{
			alert("Please select options for transaction");
			$("#tofrom").prop('selectedIndex',2);
			
			$("#amount").val("");
			location.reload(true);
			return false;
		}
		else
		{
			params+= '&' + 'type' + '=' + type;
			params+= '&' + 'amount' + '=' + amount;
			params+= '&' + 'from' + '=' + $("#from").val();
			if(type == 'owedto')
			{
				var to = $("#toselect option:selected").val();
				params+= '&' + 'to' + '=' + to;
				if(to == 'select')
				{
					alert("Please select options for transaction");
					$("#toselect").prop('selectedIndex',0);
					location.reload(true);
					return false;
				}
				else
				{
					$.ajax({
							type: "POST",
							url: "/assignment/transfer",
							data: params,
							success: function(result){
								//window.location.href = "/assignment/signup"
								//alert(result);
								if(result.code == true)
								{
									alert(result.message);
									location.reload(true);
									return true;
								}
								else
								{
									alert(result.message);
									location.reload(true);
									return false;
								}
								//return true;
							}
						});
				}
			}
			else
			{
				var to = $("#fromselect option:selected").val();
				params+= '&' + 'to' + '=' + to;

				if(to == 'select')
				{
					alert("Please select options for transaction");
					$("#fromselect").prop('selectedIndex',0);
					location.reload(true);
					return false;
				}
				else
				{
					$.ajax({
							type: "POST",
							url: "/assignment/repay",
							data: params,
							success: function(result){
								//window.location.href = "/assignment/signup"
								//alert(result);
								if(result.code == true)
								{
									alert(result.message);
									location.reload(true);
									return true;
								}
								else
								{
									alert(result.message);
									location.reload(true);
									return false;
								}
								//return true;
							}
					});
				}
			}

		}

	});

});