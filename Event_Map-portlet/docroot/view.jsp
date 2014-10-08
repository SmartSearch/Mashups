<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0;
	padding: 0
}

#map_canvas {
	height: 100%
}
</style>
<script src="http://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
    // The markers array contains the actual Marker objects.
    var markers = [];
	var map;
    var locationIcon;
    var infowindow = null;
    
    // Google Maps Script addition
    function loadScript() {
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyDY0kkJiTPVd2U7aTOAwhc9ySH6oHxOIYM&sensor=false&callback=initialize";
		document.body.appendChild(script);
	}

	// Map Initialization.
	function initialize() {
		var mapProp = {
			center : new google.maps.LatLng(37.975556,23.734722),
			zoom : 9,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
	}
	
	// Create a Location Marker.
	function createLocationMarker(title,address,latitude,longitude,id,rank,score,locationId,startTime,desc) {
	
		var newLocation =  new google.maps.LatLng(latitude,longitude);
		
			var locationMarker = new google.maps.Marker();
		
			if (score <= 0.33333333) {
				locationIcon = new google.maps.MarkerImage(
					"http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png"
				);
			}else if (score > 0.33333333 && score <= 0.66666666) {
				locationIcon = new google.maps.MarkerImage(
					"http://www.google.com/intl/en_us/mapfiles/ms/micons/yellow-dot.png"
				);
			}else {
				locationIcon = new google.maps.MarkerImage(
					"http://www.google.com/intl/en_us/mapfiles/ms/micons/green-dot.png"
				);
			}
		
			locationMarker.setOptions({
				icon: locationIcon,
				draggable: true,
				position: newLocation
			});
			markers.push(locationMarker);
			locationMarker.setMap(map);
		
			google.maps.event.addListener(locationMarker, "click", function() {
				if (infowindow != null) {
			        infowindow.close();
			    }
				infowindow = new google.maps.InfoWindow({
					content: "<p style='text-align:center'><b>" + title + " - " + address + "</b></p><b>ID: </b>" + id  + "</br><b>Rank: </b>" + rank  + "</br><b>Score: </b>" + score + "</br><b>Location ID: </b>" + locationId + "</br><b>Event Time: </b>" + new Date(startTime) + "</br><b>Description: </b>" + desc
				});
				infowindow.open(map,locationMarker);
			});

		map.setCenter(newLocation);
	}

	function selectMarker(index) {
		map.setCenter(markers[index].getPosition());
		google.maps.event.trigger(markers[index], 'click');
	}
	
	function clear() {

		for (var i = 0; i < markers.length; i++ ) {
			markers[i].setMap(null);
		}
		markers = [];

	}
	
	var <%= renderResponse.getNamespace() %>eventFlag;
	
	if (<%= renderResponse.getNamespace() %>eventFlag != true) {
		Liferay.on( "new_MapPoints",
			function(data) {
				if (markers.length > 0)
					clear();
			}
		);
		Liferay.on( "MapPoint_Create",
			function(data) {
				createLocationMarker(data.title,data.address,data.lat,data.lon,data.id,data.rank,data.score,data.locationId,data.startTime,data.desc);
			}
		);
		Liferay.on( "select_MapPoint",
			function(data) {
				selectMarker(data.index);
			}
		);
		<%= renderResponse.getNamespace() %>eventFlag = true;
	}

	$(document).ready(function() {
		setTimeout(function() {
		    loadScript();
		}, 1000);
	});
</script>
</head>

<body>
	<div id="container" style="width:100%; height:450px">
		<div id="googleMap" style="width: 100%; height: 100%"></div>
	</div>
</body>

</html>