package com.mvc.portlets;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

//import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class ConfigurationActionImpl extends DefaultConfigurationAction {

	@Override
	public void processAction(PortletConfig portletConfig,
			ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {
		System.out.println("***Inside processAction of Config****");
		String url = actionRequest.getParameter("URL");
		String height = actionRequest.getParameter("height");
		PortletPreferences preferences = actionRequest.getPreferences();

		String portletResource = ParamUtil.getString(actionRequest, "portletResource");

		if (Validator.isNotNull(portletResource)) {
			preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);
		}
		
		preferences.setValue("URL", url);
		preferences.setValue("height", height);
		preferences.store();
		
		SessionMessages.add( actionRequest,portletConfig.getPortletName() + SessionMessages.KEY_SUFFIX_REFRESH_PORTLET, portletResource);
		super.processAction(portletConfig, actionRequest, actionResponse);
		
	}

	@Override
	public String render(PortletConfig portletConfig,
			RenderRequest renderRequest, RenderResponse renderResponse)
			throws Exception {
		System.out.println("***Inside render of Config****");
		// TODO Auto-generated method stub
		return "/configuration.jsp";

	}

}
