<%
	response.setContentType("application/json");
%>

{
	"sub": "<%=request.getHeader("Subject")%>",
	"groups":[
		"group1","group2"
	],
	"given_name":"<%=request.getHeader("X-FIRSTNAME")%>",
	"acr":"<%=request.getHeader("X-ACR")%>"
}