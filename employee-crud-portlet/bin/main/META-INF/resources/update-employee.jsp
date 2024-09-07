<%@page import="com.liferay.Employee.service.EmployeeLocalServiceUtil"%>
<%@page import="com.liferay.Employee.model.Employee"%>
<%@page import="java.util.List"%>
<%@ include file="init.jsp"%>
<portlet:defineObjects/>
<portlet:actionURL name="updateEmployee" var="updateEmpActionURL"/>
<portlet:renderURL var="backUrl"><portlet:param name="jspPage" value="/view-employee.jsp"/></portlet:renderURL>
<aui:form action="<%=updateEmpActionURL%>" name="employeeForm" method="POST"/>

<%

	long empId = ParamUtil.getLong(request, "employeeid");
	System.out.println("---Inside update page---");
	Employee employee=null;
	if(empId > 1){
		employee=EmployeeLocalServiceUtil.fetchEmployee(empId);
	}
	System.out.println("First Name:"+employee.getFirstName());
	//Employee employee = EmployeeLocalServiceUtil.getEmployee(Long.valueOf(empId));
	
%>
 <aui:form action="<%= updateEmpActionURL %>" method="post" >
	<aui:input name="empId" type="hidden" value="<%=employee.getEmpId()%>"/>
	<aui:input name="enrollmentNo" type="text" value="<%=employee.getEnrollmentNo()%>"/>
	<aui:input name="firstName" type="text" value="<%=employee.getFirstName()%>"/>
	<aui:input name="lastName" type="text" value="<%=employee.getLastName()%>" />
	<aui:input name="contactNo" type="text" value="<%=employee.getContactNo()%>" />
	<aui:input name="city" type="text" value="<%=employee.getCity()%>"/>
	<aui:button type="submit" value="Update" name=""></aui:button>
	<aui:button type="cancel" value="Back" onClick="<%=backUrl.toString()%>"></aui:button>
</aui:form>