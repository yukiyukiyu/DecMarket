<html>
<body>

<%
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "/index");
%>

</body>
</html>
