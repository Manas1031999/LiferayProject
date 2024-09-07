package com.liferay.employee.portlet;

import com.liferay.Employee.model.Employee;
import com.liferay.Employee.service.EmployeeLocalService;
import com.liferay.counter.kernel.service.CounterLocalService;
import com.liferay.employee.constants.EmployeeCrudPortletKeys;
import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;

import java.io.IOException;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.ProcessAction;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author mtpr405
 */
@Component(immediate = true, property = { "com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css", "com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=EmployeeCrud", "javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view-employee.jsp",
		"javax.portlet.name=" + EmployeeCrudPortletKeys.EMPLOYEECRUD, "javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user" }, service = Portlet.class)
public class EmployeeCrudPortlet extends MVCPortlet {

	private Log log = LogFactoryUtil.getLog(this.getClass().getName());

	@Reference
	CounterLocalService counterLocalService;

	@Reference
	EmployeeLocalService employeeLocalService;
	
	@ProcessAction(name ="addEmployee")
	public void addEmployee(ActionRequest actionRequest, ActionResponse actionResponse) {
		long empId = counterLocalService.increment(Employee.class.getName());

		String enrollmentNo = ParamUtil.getString(actionRequest, "enrollmentNo");
		String firstName = ParamUtil.getString(actionRequest, "firstName");
		String lastName = ParamUtil.getString(actionRequest, "lastName");
		String contactNo = ParamUtil.getString(actionRequest, "contactNo");
		String city = ParamUtil.getString(actionRequest, "city");
		int status=1;

		Employee emp = employeeLocalService.createEmployee(empId);

		emp.setEmpId(empId);
		emp.setEnrollmentNo(enrollmentNo);
		emp.setFirstName(firstName);
		emp.setLastName(lastName);
		emp.setContactNo(contactNo);
		emp.setCity(city);
		emp.setStatus(status);
		
		System.out.println(empId + " "+enrollmentNo+" "+firstName+" "+lastName+" "+contactNo+" "+city+" "+status);

		employeeLocalService.addEmployee(emp);

	}

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		List<Employee> empList = employeeLocalService.getEmployees(QueryUtil.ALL_POS, QueryUtil.ALL_POS);

		renderRequest.setAttribute("empList", empList);
		super.render(renderRequest, renderResponse);
	}
	
	@ProcessAction(name = "updateEmployee")
	public void updateEmployee(ActionRequest actionRequest, ActionResponse actionResponse) {
		long empId = ParamUtil.getLong(actionRequest, "empId", GetterUtil.DEFAULT_LONG);
		String enrollmentNo = ParamUtil.getString(actionRequest, "enrollmentNo", GetterUtil.DEFAULT_STRING);
		String firstName = ParamUtil.getString(actionRequest, "firstName", GetterUtil.DEFAULT_STRING);
		String lastName = ParamUtil.getString(actionRequest, "lastName", GetterUtil.DEFAULT_STRING);
		String contactNo = ParamUtil.getString(actionRequest, "contactNo", GetterUtil.DEFAULT_STRING);
		String city = ParamUtil.getString(actionRequest, "city", GetterUtil.DEFAULT_STRING);
		
		Employee emp=null;
		try {
			emp=employeeLocalService.getEmployee(empId);
		}catch(Exception e) {
			log.error(e.getCause(), e);
		}
		
		if(Validator.isNotNull(emp)) {
			emp.setEnrollmentNo(enrollmentNo);
			emp.setFirstName(firstName);
			emp.setLastName(lastName);
			emp.setContactNo(contactNo);
			emp.setCity(city);
			employeeLocalService.updateEmployee(emp);
		}
		
	}
	
	@ProcessAction(name = "deleteEmployee")
	public void deleteEmployee(ActionRequest actionRequest, ActionResponse actionResponse){
		System.out.println("---Inside delete method---");
		long employeeId = ParamUtil.getLong(actionRequest, "employeeid");
		System.out.println("employeeId : "+employeeId);
		Employee employee = null;
		try {
			if(Validator.isNotNull(employeeId)) {
				employee = employeeLocalService.getEmployee(employeeId);
				employeeLocalService.deleteEmployee(employee);
				System.out.println("Deleted successfully......");
			}
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
	}
	
	@ProcessAction(name = "deactiveActiveEmployee")
	public void activeDeActiveEmployee(ActionRequest actionRequest, ActionResponse actionResponse) {
		System.out.println("---Inside active deactive method-----");
		long employeeId = ParamUtil.getLong(actionRequest, "employeeid");
		Employee employee=null;
		try {
			employee=employeeLocalService.getEmployee(employeeId);
			if (employee.getStatus()==0) {
				employee.setStatus(1);
			}
			else {
				employee.setStatus(0);
			}
			
			employeeLocalService.updateEmployee(employee);
			System.out.println("------Status updated-----");
		}catch(Exception e) {
			log.error(e.getCause(), e);
		}
		
		
	}

}