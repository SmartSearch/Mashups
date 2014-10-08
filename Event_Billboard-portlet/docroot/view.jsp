<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>
      Event Billboard
    </title>
  </head>
  <body>
  	<div id="acc_container" style="max-height: 850px; max-width: 220px; word-wrap: break-word;"></div>
  </body>
  <script type="text/javascript">
	function timeDifference(current, previous) {

		var msPerMinute = 60 * 1000;
		var msPerHour = msPerMinute * 60;
		var msPerDay = msPerHour * 24;
		var msPerMonth = msPerDay * 30;
		var msPerYear = msPerDay * 365;

		var elapsed = current - previous;

		if (elapsed > 0) {
			if (elapsed < msPerMinute) {
				return Math.round(elapsed/1000) + ' second(s) ago';   
			}
			else if (elapsed < msPerHour) {
				return Math.round(elapsed/msPerMinute) + ' minute(s) ago';   
			}
			else if (elapsed < msPerDay ) {
				return Math.round(elapsed/msPerHour ) + ' hour(s) ago';   
			}
			else if (elapsed < msPerMonth) {
				return 'approximately ' + Math.round(elapsed/msPerDay) + ' day(s) ago';   
			}
			else if (elapsed < msPerYear) {
				return 'approximately ' + Math.round(elapsed/msPerMonth) + ' month(s) ago';   
			}
			else {
				return 'approximately ' + Math.round(elapsed/msPerYear ) + ' year(s) ago';   
			}
		}else {
			elapsed = Math.abs(elapsed);
			
			if (elapsed < msPerMinute) {
				return 'in ' + Math.round(elapsed/1000) + ' second(s)';   
			}
			else if (elapsed < msPerHour) {
				return 'in ' + Math.round(elapsed/msPerMinute) + ' minute(s)';   
			}
			else if (elapsed < msPerDay ) {
				return 'in ' + Math.round(elapsed/msPerHour ) + ' hour(s)';   
			}
			else if (elapsed < msPerMonth) {
				return 'in approximately ' + Math.round(elapsed/msPerDay) + ' day(s)';   
			}
			else if (elapsed < msPerYear) {
				return 'in approximately ' + Math.round(elapsed/msPerMonth) + ' month(s)';   
			}
			else {
				return 'in approximately ' + Math.round(elapsed/msPerYear ) + ' year(s)';   
			}
		}
	}
	
	function createAccordion(query, data) {
		
		var items = [];
		
		document.getElementById('acc_container').innerHTML= '';

		Liferay.fire("new_MapPoints", {});
		
		Liferay.fire("new_nonAV_Events", {});
		
		Liferay.fire("new_MediaEvents", {});
		
		Liferay.fire("new_Social_Data", {});
		
		Liferay.fire("new_Triggers", {});
		
		var i = 0;
		var title = document.createElement("h1");
		title.innerHTML = 'Query: "' + query + '"';
		document.getElementById("acc_container").appendChild(title);
		
		var accordion = document.createElement("div");
		accordion.setAttribute("id", "accordion");
		document.getElementById("acc_container").appendChild(accordion);
		
		var result_count = 8;
		
		if (data.results.length < result_count )
			result_count = data.results.length;
		
		for (i=0 ; i<result_count ; i++) {
			items.push(data.results[i]);
			
			Liferay.fire("MapPoint_Create", {
				title : data.results[i].title,
				address : data.results[i].locationAddress,
				lat : data.results[i].lat,
				lon : data.results[i].lon,
				id : data.results[i].id,
				rank : data.results[i].rank,
				score : data.results[i].score,
				locationId : data.results[i].locationId,
				startTime : data.results[i].startTime,
				desc : data.results[i].description,
				uri : data.results[i].URI
			});
			
			var dtArray = data.results[i].startTime.split("T");
			var dateTime = dtArray[0] + " " + dtArray[1].split(".")[0] ;
			
			var header = document.createElement("h3");
			header.innerHTML = data.results[i].locationName + "<br>" + dateTime;
			document.getElementById("accordion").appendChild(header);
			
			var div = document.createElement("div");
			div.setAttribute("id", "result" + i);
			div.setAttribute("name", i);
			div.style.height = "200px";
			document.getElementById("accordion").appendChild(div);
		}

		setTimeout(function() {
			var j;
			$( "#accordion" ).accordion({
				heightStyle: "fill",
				collapsible: true,
			});
			
			for (j=0 ; j<items.length ; j++) {
				new PrettyJSON.view.Node({ 
					el:$("#result" + j), 
					data:items[j]
				});
			}
			
			$( "#accordion" ).on( "accordionactivate", function( event, ui ) {
				var json = items[ui.newPanel.attr("name")];

				if (json != undefined) {
					
					Liferay.fire("MediaEvent", {
						mediaURL : json.media
					});
					
					Liferay.fire("select_MapPoint", {
						index : $('#accordion').accordion('option', 'active')
					});
					
					Liferay.fire("new_nonAV_Events", {});
					Liferay.fire("new_Social_Data", {});
					Liferay.fire("new_Triggers", {});
					if(json.observations != "") {
						$.each(json.observations, function(key,val) {
							if (key != "topTweets") {
								Liferay.fire("nonAV_Event", {
									sensorID: key,
									measurement: val
								});
							}else {
								$.each(json.observations.topTweets, function(key,val) {
									//alert(JSON.stringify(val));
									Liferay.fire("social_Data_Twitter", {
										json: val
									});
								});
							}
						});
					}
					
					if(json.triggers != "") {
						$.each(json.triggers, function(key,val) {
							Liferay.fire("trigger_Event", {
								trigger: val
							});
						});
					}
				}
				
			} );
			
			$( "#accordion" ).accordion( "option", "active", 1 );
			$( "#accordion" ).accordion( "option", "active", 0 );
		},200);
		
	}
	
	var <%= renderResponse.getNamespace() %>eventFlag;
		
	if (<%= renderResponse.getNamespace() %>eventFlag != true) {
		Liferay.on( "json_result",
			function(data) {
				//alert("JSON Response Received! : " + JSON.stringify(data.json));
				createAccordion(data.query,data.json);
			}
		);
		<%= renderResponse.getNamespace() %>eventFlag = true;
	}	
    </script>
</html>
