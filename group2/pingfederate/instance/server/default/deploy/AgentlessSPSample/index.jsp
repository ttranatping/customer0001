<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import = "com.pingidentity.sample.configuration.SpSampleConstants" %>
<%@ page import = "java.lang.StringBuilder" %>

<%
	String baseUrl = request.getContextPath() + SpSampleConstants.APP_PATH;
	String queryParams = request.getQueryString();
	StringBuilder url = new StringBuilder();
	url.append((queryParams != null) ? baseUrl + "?" + queryParams : baseUrl);

	response.sendRedirect(url.toString());
%>
