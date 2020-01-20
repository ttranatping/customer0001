<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
		<base href="https://sso.pingapac.com/"/>
		<link href="assets/consent/font-awesome.css" rel="stylesheet">
    	<link rel="stylesheet" href="assets/consent/foundation.css">
    	<link rel="stylesheet" href="assets/consent/app.css">
    	<link rel="stylesheet" href="assets/consent/layout.css">
    	<link rel="stylesheet" href="assets/consent/card-user-profile.css">
		<meta class="foundation-mq">
	</head>
	<body>

        <form method="post">
			<div class="grid-container" style="max-width: 600px">
				<div class="row align-center medium-unstack">
					<div class="medium-5 large-4 column">
						<div class="card-user-profile">
							<img class="card-user-profile-img" src="./assets/consent/transfer.png" alt="picture of space">
							<div class="card-user-profile-content card-section">
								<div class="card-user-profile-avatar">
									<img src="./assets/consent/logo.jpg" alt="picture of yeti">
								</div>
								<h1>Transfer Form</h1>
								<p class="card-user-profile-info">Hi <%=request.getHeader("X-GIVENNAME")%></p>
								<%
								if(request.getParameter("amount") != null)
								{
								%>
									<p class="card-user-profile-info" style="color: green;"><b>You have transferred amount: </b><%= request.getParameter("amount")%></p>
								<%
								}
								%>
								
								<%
								String paymentMax = (request.getHeader("X-PAYMENTMAX") != null && !request.getHeader("X-PAYMENTMAX").isEmpty())?request.getHeader("X-PAYMENTMAX"):"20000";
								
								if(request.getHeader("X-ACR") !=null && request.getHeader("X-ACR").equalsIgnoreCase("2FA"))
								{
								%>
									<p class="card-user-profile-info">You have performed strong authentication and can submit any amount up to $<%=paymentMax%>.</p>
								<%
								}else
								{
									String paymentThreshold = (request.getHeader("X-PAYMENTTHRESHOLD") != null && !request.getHeader("X-PAYMENTTHRESHOLD").isEmpty())?request.getHeader("X-PAYMENTTHRESHOLD"):"1000";
									
								%>
									<p class="card-user-profile-info">You have configured your payment threshold to be $<%=paymentThreshold%>. Anything above this will require stronger authentication. Your maximum amount is $<%=paymentMax%>.</p>
									<p class="card-user-profile-info">You can change the threshold amount by <a href="https://brand1.pingapac.com/pf/idprofile.ping?LocalIdentityProfileID=yABlNHg7OWx28Rcw" target="_blank">updating your profile</a>.</p>
								<%
								}
								%>
								<label>Amount
									<input id="amount" type="text" size="36" name="amount" value="" autocorrect="off"
							   			autocapitalize="off" onKeyPress="return postOnReturn(event)"/>
								</label>
						
							</div>
							<div class="card-user-profile-actions">
								<a onclick="postOk();" class="card-user-profile-button button hollow">Submit</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>

	<script type="text/javascript">

		function postOk() {
			document.forms[0].submit();
		}
		function postCancel() {
			document.forms[0].submit();
		}

	function postOnReturn(e)
			{
				var keycode;
				if (window.event) keycode = window.event.keyCode;
				else if (e) keycode = e.which;
				else return true;

				if (keycode == 13)
				{
					document.forms[0].submit();
					return false;
				}
				else
					return true;
			 }
	</script>
</html>


