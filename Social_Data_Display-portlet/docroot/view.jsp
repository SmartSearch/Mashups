
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

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<portlet:defineObjects />

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>jQuery UI Tabs - Content via Ajax</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#twitter">Twitter</a></li>
		</ul>
		<div id="twitter" style="min-height:200px; max-height:300px; overflow-x:scroll;">
		</div>
	</div>
</body>
<script>
	var <%= renderResponse.getNamespace() %>eventFlag;
	var num=0;
	
	function remove_social_inputs(){
		document.getElementById("twitter").innerHTML= "";
		num=0;
	}
	
	function createTweet(json) {
		
		var containerDiv = document.createElement("div");
		containerDiv.setAttribute("class", "containerDiv");
		containerDiv.setAttribute("id", "<%= renderResponse.getNamespace() %>containerDiv_" + num);
		document.getElementById("twitter").appendChild(containerDiv);
		
		if (num>0) {
			document.getElementById("<%= renderResponse.getNamespace() %>containerDiv_" + num).appendChild(document.createElement("hr"));
		}

		var imageContainerDiv = document.createElement("div");
		imageContainerDiv.setAttribute("class", "imageContainerDiv");
		imageContainerDiv.setAttribute("align", "center");
		imageContainerDiv.setAttribute("id", "<%= renderResponse.getNamespace() %>imageContainerDiv_" + num);
		document.getElementById("<%= renderResponse.getNamespace() %>containerDiv_" + num).appendChild(imageContainerDiv);

		document.getElementById("<%= renderResponse.getNamespace() %>imageContainerDiv_" + num).innerHTML = "<b>" + json.user.name + "</b><br>";

		var userImg = document.createElement("img");
		userImg.setAttribute("src", json.user.profile_image_url);
		userImg.setAttribute("title", json.created_at);
		userImg.setAttribute("class", "userImg");
		document.getElementById("<%= renderResponse.getNamespace() %>imageContainerDiv_" + num).appendChild(userImg);

		var textContainerDiv = document.createElement("div");
		textContainerDiv.setAttribute("class", "textContainerDiv");
		textContainerDiv.setAttribute("id", "<%= renderResponse.getNamespace() %>textContainerDiv_" + num);
		document.getElementById("<%= renderResponse.getNamespace() %>containerDiv_" + num).appendChild(textContainerDiv);

		document.getElementById("<%= renderResponse.getNamespace() %>textContainerDiv_" + num).innerHTML = "<br>" + json.text;
			
		num++;
	}

	if (<%= renderResponse.getNamespace() %>eventFlag != true) {
		Liferay.on("new_Social_Data",
			function(data) {
				remove_social_inputs();
			}
		);
  		Liferay.on("social_Data_Twitter",
			function(data) {
  				createTweet(data.json);
			}
  		);
  		<%= renderResponse.getNamespace() %>eventFlag = true;
	}
	
	$(function() {
		
		$("#tabs").tabs({
			beforeLoad : function(event, ui) {
				ui.jqXHR.error(function() {
					ui.panel.html("Couldn't load this tab. We'll try to fix this as soon as possible. ");
				});
			}
		});
	});
</script>
</html>