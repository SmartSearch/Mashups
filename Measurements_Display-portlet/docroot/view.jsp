<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<portlet:defineObjects />

	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" type="text/css">
    <script src="http://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>

	<style>
	#nonAVs
	{
		max-height:850px;
		overflow-x:scroll;
		align: center;
	}

.ui-widget-shadow.ui-corner-all
	{
		width: 180px;
		height: 70px;
		margin: 6px;
		opacity: 1;
		position:relative;
	}
	
.ui-widget.ui-widget-content.ui-state-default.ui-corner-all
	{
		width: 90%;
		height: 90%;
		padding: 7px;
		position: relative;
	}
	
.sensorID
	{
		font-size:110%;
		font-weight:bold;
		margin: 0;
		margin-top: 2px;
	}
	
.ui-widget-shadow.ui-state-active.ui-corner-all
	{
		width: 85%;
		height: 50%;
		margin: 5px;
		padding: 3px;
		font-weight:bold;
		font-size:120%;
		opacity: 1;
		color:#AFAFAF;
	}
	
.measurement
	{
		margin-top: 4px;
	}
	
	</style>
	<div id="nonAVs" style="max-height: 850px; max-width: 220px"></div>
  	<script>
		var <%= renderResponse.getNamespace() %>eventFlag;
		var num=0;
		
		function remove_inputs(){
			document.getElementById('nonAVs').innerHTML= '';
			num=0;
		}
		
		function createMeasurementDisplay(data) {
			var containerDiv = document.createElement("div");
			containerDiv.setAttribute("class", "ui-widget-shadow ui-corner-all");
			containerDiv.setAttribute("align", "center");
			containerDiv.setAttribute("id", "<%= renderResponse.getNamespace() %>containerDiv_" + num);
			document.getElementById("nonAVs").appendChild(containerDiv);

			var containerDiv2 = document.createElement("div");
			containerDiv2.setAttribute("class", "ui-widget ui-widget-content ui-state-default ui-corner-all");
			containerDiv2.setAttribute("align", "center");
			containerDiv2.setAttribute("id", "<%= renderResponse.getNamespace() %>containerDiv2_" + num);
			document.getElementById("<%= renderResponse.getNamespace() %>containerDiv_" + num).appendChild(containerDiv2);

			var sensorID_p = document.createElement("p");
			sensorID_p.setAttribute("id", "<%= renderResponse.getNamespace() %>sensorID_" + num);
			sensorID_p.setAttribute("class", "sensorID");
			sensorID_p.innerHTML = "Sensor ID";
			document.getElementById("<%= renderResponse.getNamespace() %>containerDiv2_" + num).appendChild(sensorID_p);

			var containerDiv3 = document.createElement("div");
			containerDiv3.setAttribute("class", "ui-widget-shadow ui-state-active ui-corner-all");
			containerDiv3.setAttribute("align", "center");
			containerDiv3.setAttribute("id", "<%= renderResponse.getNamespace() %>containerDiv3_" + num);
			document.getElementById("<%= renderResponse.getNamespace() %>containerDiv2_" + num).appendChild(containerDiv3);

			var measurement_p = document.createElement("p");
			measurement_p.setAttribute("id", "<%= renderResponse.getNamespace() %>measurement_" + num);
			measurement_p.setAttribute("class", "measurement");
			measurement_p.innerHTML = "Measurement";
			document.getElementById("<%= renderResponse.getNamespace() %>containerDiv3_" + num).appendChild(measurement_p);

			var hr3 = document.createElement("hr");
			document.getElementById("nonAVs").appendChild(hr3);

			document.getElementById("<%= renderResponse.getNamespace() %>sensorID_" + num).innerHTML = data.sensorID;
			document.getElementById("<%= renderResponse.getNamespace() %>measurement_" + num).innerHTML = data.measurement;
				
			num++;
		}
		
		if (<%= renderResponse.getNamespace() %>eventFlag != true) {
			Liferay.on("new_nonAV_Events",
				function(data) {
					remove_inputs();
				}
			);
	  		Liferay.on("nonAV_Event",
				function(data) {
	  				createMeasurementDisplay(data);
				}
	  		);
	  		<%= renderResponse.getNamespace() %>eventFlag = true;
		}
  	</script>