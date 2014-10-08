<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>

<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.RenderRequest" %>


<portlet:defineObjects />
<liferay-ui:success key="success" message="Data passed successfully" />
<%
	PortletPreferences preferences = renderRequest.getPreferences();
	
	String portletResource = ParamUtil.getString(request, "portletResource");
	
	if (Validator.isNotNull(portletResource)) {
		preferences = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);
	}

	String param_url = preferences.getValue("URL","");
	String param_height = preferences.getValue("height","");
%>
<form action='<liferay-portlet:actionURL portletConfiguration="true" />' method="post" name="<portlet:namespace />fm" >
<table>
	<tr>
		<td>URL:</td>
		<td>
			<%
				if (preferences != null) {
			%>
				<input class="lfr-input-text" name="URL" type="text" value="<%=param_url %>" />
			<%
				}
			%>
		</td>
	</tr>
	<tr>
		<td>Height:</td>
		<td>
			<%
				if (preferences != null) {
			%>
				<input class="lfr-input-text" name="height" type="text" value="<%=param_height %>" />
			<%
				}
			%>
		</td>
	</tr>
	<tr align="center">
		<td><input type="submit" value='<liferay-ui:message key="save" />' /></td>
	</tr>
</table>

</form>
