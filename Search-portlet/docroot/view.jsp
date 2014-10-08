<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>

<portlet:defineObjects />

<script src="http://code.jquery.com/jquery-1.9.1.js"
	type="text/javascript"></script>
<div id="loading">
	<img src='<%=renderResponse.encodeURL(renderRequest.getContextPath() + "/loading-image.gif")%>' style="border-style: none;" width="100%" height="100%" />
</div>
<div id="search">
	<span style="font-size:22px;"><b>Search for Events</b></span><br><br>
	<input type="text" name="queryInput" id="queryInput" value="" style="width:180px;">
	&nbsp
	<input type="radio" name="searchType" value="anywhere" checked>Anywhere
	&nbsp
	<input type="radio" name="searchType" value="aroundMe" disabled>Around Me
	&nbsp
	<input type="checkbox" name="since" id="since">Since: 
	<input type="text" name="sinceDate" id="sinceDate" value="" placeholder="yyyy-MM-ddThh:mm:ss" style="width:130px;">
	<br>
	<br>
	<button type="button" id="srchBtn" onClick="searchRequest()">Smart Search</button>
</div>
<script>
	function createRequest() {
		var result=null;
		if (window.XMLHttpRequest) {
			// FireFox, Safari, etc.
			result = new XMLHttpRequest();
			//result.overrideMimeType('text/plain'); // Or anything else
		} else if (window.ActiveXObject) {
			// MSIE
			result = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			// No known mechanism -- consider aborting the application
			alert("Non-Compatible Browser!");
		}
		return result;
	}
	
	function searchRequest() {
		
		if (document.getElementById("queryInput").value == "") {
			alert("Please Provide A Term.");
			return null;
		}
		document.getElementById("loading").style.visibility = "visible";
		//$("#loading").show();
		document.getElementById("search").style.visibility = "hidden";
		
		var req = createRequest();
		var postBody = "url=http://demos.terrier.org/v1/search.json?q=" + encodeURIComponent(document.getElementById("queryInput").value);
		
		if (document.getElementById("since").checked && document.getElementById("sinceDate").value!="") {
			postBody = postBody + encodeURIComponent("&since=" + document.getElementById("sinceDate").value);
		}
		var urltosend = "http://maps.smartfp7.telesto.gr/SMART_EdgeNodes_Map/webServer/getJson";

		req.open("post", urltosend, true);
		req.timeout = 40000;
	    req.ontimeout = function () { alert("Request Timed out!"); };
		req.send(postBody);

		req.onreadystatechange = function() {
			if (req.readyState != 4) {
				return;
			}
			if (req.status != 200) {
				alert("Error: " + req.status + " / " + req.statusText);
				document.getElementById("loading").style.visibility = "hidden";
				document.getElementById("search").style.visibility = "visible";
				return;
			}
			Liferay.fire("json_result", {
				query: document.getElementById("queryInput").value,
				json : JSON.parse(req.responseText)
			});
			document.getElementById("loading").style.visibility = "hidden";
			document.getElementById("search").style.visibility = "visible";
		};
	}
	
	$("#queryInput").keyup(function(event){
    	if(event.keyCode == 13){
        	$("#srchBtn").click();
        	event.preventDefault();
        	return false;
    	}
	});
</script>