<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@
taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%@page import="com.liferay.portal.kernel.util.*"%>

<liferay-theme:defineObjects />

<portlet:defineObjects />

<%-- <%
String currentURL = PortalUtil.getCurrentURL(request);
long empId = ParamUtil.getLong(request, "empId");
String enrollmentNo = ParamUtil.getString(request, "enrollmentNo");
String firstName = ParamUtil.getString(request, "firstName");
String lastName = ParamUtil.getString(request, "lastName");
String contactNo = ParamUtil.getString(request, "contactNo");
String city = ParamUtil.getString(request, "city");
String studentAddress = ParamUtil.getString(request, "studentAddress");

%> --%>