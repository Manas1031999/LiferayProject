<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@ include file="init.jsp"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="com.liferay.Employee.service.EmployeeLocalServiceUtil"%>
<%@page import="com.liferay.Employee.model.Employee"%>
<%@page import="java.util.List"%>
<%@page import="javax.servlet.jsp.*"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<liferay-portlet:renderURL var="addEmpActionURL">
	<portlet:param name="mvcPath" value="/add-employee.jsp" />
</liferay-portlet:renderURL>




<a href="<%=addEmpActionURL%>"><button>Add Employee</button> </a>
<liferay-portlet:renderURL varImpl="iteratorURL">
	<portlet:param name="mvcPath" value="/view_employee.jsp" />
</liferay-portlet:renderURL>
<%
	List<Employee> employeeList = EmployeeLocalServiceUtil.getEmployees(-1, -1);
	System.out.println("List Size: " + employeeList.size());
	if (employeeList.size() > 0) {
%>

<liferay-ui:search-container total="<%=employeeList.size()%>"
	var="searchContainer" emptyResultsMessage="there-are-no-employees"
	iteratorURL="<%=iteratorURL%>" delta="4">
	<liferay-ui:search-container-results results="<%=ListUtil.subList(employeeList, searchContainer.getStart(), searchContainer.getEnd()) %>" />
	<liferay-ui:search-container-row
		className="com.liferay.Employee.model.Employee" modelVar="emp"
		keyProperty="empId">

		<liferay-portlet:renderURL var="editEmpURL">
			<portlet:param name="mvcPath" value="/update-employee.jsp" />
			<portlet:param name="employeeid" value="${emp.empId}" />
		</liferay-portlet:renderURL>

		<liferay-portlet:actionURL name="deleteEmployee"
			var="deleteEmployeeActionURL">
			<portlet:param name="employeeid" value="${emp.empId}" />
		</liferay-portlet:actionURL>
		<liferay-portlet:actionURL name="deactiveActiveEmployee"
			var="actDeActEmployeeActionURL">
			<portlet:param name="employeeid" value="${emp.empId}" />
		</liferay-portlet:actionURL>

		<liferay-ui:search-container-column-text name="Employee Id"
			value="${emp.empId}" />
		<liferay-ui:search-container-column-text name="Enrollment No"
			value="${emp.enrollmentNo}" />
		<liferay-ui:search-container-column-text name="First Name"
			value="${emp.firstName}" />
		<liferay-ui:search-container-column-text name="Last Name"
			value="${emp.lastName}" />
		<liferay-ui:search-container-column-text name="Contact No"
			value="${emp.contactNo}" />
		<liferay-ui:search-container-column-text name="City"
			value="${emp.city}" />
		<liferay-ui:search-container-column-text name="Status"
			value="${emp.status}" />
		<liferay-ui:search-container-column-text>
			<liferay-ui:icon-menu icon="" markupView="lexicon" message="actions"
				showWhenSingleIcon="<%=true%>">
				
				<c:set var="empId" value="${emp.empId}" />
				<%-- 
				<%
					long employeeId = (long) pageContext.getAttribute("empId");
								System.out.println("employeeId: " + employeeId);
								PortletURL editUrl = renderResponse.createRenderURL();
								editUrl.setParameter("employeeId", String.valueOf(employeeId));
								editUrl.setParameter("mvcPath", "/update-employee.jsp");
								
								PortletURL deleteActionUrl = renderResponse.createActionURL();
								deleteActionUrl.setWindowState(LiferayWindowState.NORMAL);
								deleteActionUrl.setParameter("employeeId", String.valueOf(employeeId));
				%>
				 --%>
				<liferay-ui:icon message="Edit" url="<%=editEmpURL%>"></liferay-ui:icon>
				<liferay-ui:icon-delete message="Delete" url="<%=deleteEmployeeActionURL.toString() %>">
					<aui:script use="liferay-util-window">
						function deleteEmployee(empId){
							var confirmation = confirm("Are you sure you want to delete?");
							
							if(confirmation){
								var deleteURL = '<%=deleteEmployeeActionURL.toString() %>' + '&employeeId=' + empId;
								Liferay.Util.navigate(deleteURL);
							}
						}
					</aui:script>
					<!-- <a href="javascript:void(0);" onclick="deleteEmployee('{empId}');">Delete</a>-->
				
				</liferay-ui:icon-delete>
				<%
					if (emp.getStatus() == 1) {
				%>
				<liferay-ui:icon message="Deactive"
					url="<%=actDeActEmployeeActionURL%>"></liferay-ui:icon>
				<%
					} else {
				%>
				<liferay-ui:icon message="Active"
					url="<%=actDeActEmployeeActionURL%>"></liferay-ui:icon>
				<%
					}
				%>
			</liferay-ui:icon-menu>
		</liferay-ui:search-container-column-text>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator markupView="lexicon" />

</liferay-ui:search-container>

<%
	} else {
%>

<br />
<span>No Record Found</span>
<%
	}
%>

<script type="text/javascript">
function confirmDel(url){
	let text = "Are you sure you want to delete?";
	if((confirm(text) == true)){
		window.location.href = url;
	}

	
	
}

</script>
