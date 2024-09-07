<%@ include file="init.jsp"%>
<portlet:defineObjects />
<portlet:actionURL name="addEmployee" var="addEmpActionURL"/>

<h2>Add Employee Form here !</h2>
<aui:form action="<%=addEmpActionURL %>" name="employeeForm" method="POST">
	<aui:input name="enrollmentNo" >
 		<aui:validator name="required"/>
 		<aui:validator name="alphanum"/>
	</aui:input>
	<aui:input name="firstName" >
 		<aui:validator name="required"/>
 		<aui:validator name="alpha"/>
	</aui:input>
	<aui:input name="lastName" >
 		<aui:validator name="required"/>
 		<aui:validator name="alpha"/>
	</aui:input>
	<aui:input name="contactNo" >
 		<aui:validator name="required"/>
 		<aui:validator name="string"/>
	</aui:input>
	<aui:input name="city">
 		<aui:validator name="required"/>
 		<aui:validator name="string"/>
	</aui:input>

	<aui:button type="submit" name="" value="Submit"></aui:button>
</aui:form>