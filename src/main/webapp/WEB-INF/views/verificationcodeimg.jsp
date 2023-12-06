<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@page import="org.healthbeauty.util.verificate.Verificate" %>
<%--<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>--%>
<%@page contentType="image/jpeg"%>
<jsp:useBean id="image" scope="page" class="org.healthbeauty.util.verificate.Verificate" />
<%
    String str = image.getCertPic(0, 0, response.getOutputStream());
    // 将认证码存入SESSION
    session.setAttribute("certCode", str);
    out.clear();
    out = pageContext.pushBody();
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
