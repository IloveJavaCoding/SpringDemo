function isAdmin() {
    const user = '<%=session.getAttribute("user")%>';
    var name = user.getUsername();
    return !!("virgo".equals(name) || "admin".equals(name));
}