<%@ page import="java.util.*" %>
<html>
<head>
    <title>Login Handler</title>
    <base href="/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="x-ua-compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="https://sso-0001.pingapac.com/assets/css/main.css"/>
</head>

<body>

<div class="ping-container ping-signin login-template">

    <!--
    if there is a logo present in the 'company-logo' container,
    then 'has-logo' class should be added to 'ping-header' container.
    -->
    <div class="ping-header" style="max-width: 1080px;">
        <span class="company-logo"><!-- client company logo here --></span>
        Login Handler
    </div>
    <!-- .ping-header -->

    <div class="ping-body-container" style="max-width: 1080px;">

        <div style="text-align: left;">
			<div class="ping-subtitle" style="text-decoration: underline">
				HTTP Headers
			</div>
			<div>
			<%
				Enumeration httpHeaderEnum = request.getHeaderNames();
				while (httpHeaderEnum.hasMoreElements()) {
					String httpHeaderName = (String) httpHeaderEnum.nextElement();
					String httpHeaderValue = request.getHeader(httpHeaderName);
				%>
					<p><span style="font-weight:bold; color: green;"><%= httpHeaderName %></span>: <%= httpHeaderValue %></p>
				<%
				}
				%>
			</div>
			<div class="ping-subtitle" style="text-decoration: underline">
				HTTP Parameters
			</div>
			<div>
			<%
				Enumeration enumerationPost = request.getParameterNames();
				while (enumerationPost.hasMoreElements()) {
					String parameterName = (String) enumerationPost.nextElement();
					String parameterValue = request.getParameter(parameterName);
				%>
					<p><span style="font-weight:bold; color: green;"><%= parameterName %></span>: <%= parameterValue %></p>
				<%
				}
				%>
			</div>
        </div><!-- .ping-body// blank div -->
        
    </div><!-- .ping-body-container -->

    <div class="ping-footer-container">
        <div class="ping-footer">
            <div class="ping-credits"></div>
            <div class="ping-copyright"></div>
        </div>
        <!-- .ping-footer -->
    </div>
    <!-- .ping-footer-container -->

</div><!-- .ping-container -->
</body>
</html>