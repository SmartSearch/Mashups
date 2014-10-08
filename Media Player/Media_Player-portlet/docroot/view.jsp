<%
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ page import="javax.portlet.PortletPreferences"%>
<portlet:defineObjects />
<%
	PortletPreferences prefs = renderRequest.getPreferences();
	String url = (String)prefs.getValue("URL", "");
	String height = (String)prefs.getValue("height", "350px");
%>

<iframe id="ifr" src="<%= url %>" style="width:100%; height:<%= height %>;" ></iframe>

<script type="text/javascript">
	var <%= renderResponse.getNamespace() %>eventFlag;
	
	if (<%= renderResponse.getNamespace() %>eventFlag != true) {
		Liferay.on( "new_MediaEvents",
			function(data) {
				document.getElementById("ifr").setAttribute("src","");
			}
		);
		Liferay.on( "MediaEvent",
			function(data) {
				document.getElementById("ifr").setAttribute("src",data.mediaURL);
			}
		);
		<%= renderResponse.getNamespace() %>eventFlag = true;
	}
  </script>