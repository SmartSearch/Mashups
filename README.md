Mashups
=======

Smart Core: Mashups components

Smart Reusable Mashups
------------------------

1. Introduction
We have developed a Visualization Framework that offer visual components (widgets) and 
describe the best practice for building applications based on intuitive interfaces, by 
combining these visual components. These widgets can communicate with each other and can 
be combined on a dashboard that adheres user management and access control management 
capabilities, based on a Role Based Access Control (RBAC) approach. 

The Visual Framework offers the required functionality by utilizing the SMART Search 
Layer to query the results and get the required data in the form of events. An event is 
an aggregation of data. E.g. a demonstration that takes place in a city is an event that 
is linked with a place, date of event, data from sensors near the event (video feeds, 
audio feeds), and user-generated data (tweets, posts) from social networks. 
 
The Visual Framework consists of two main components:
•	The Dashboard
•	Standard Visual Components (mash-ups)

---------------------

2. The Dashboard
The dashboard of our visual framework is the foundation, as it provides user 
identification and access control. Moreover it allows the deployment of visual components 
by the users. It is based on the Liferay portal. Liferay is a free and open source 
enterprise portal project providing a web platform with features commonly required for 
the development of websites and portals. It differs from the mainstream Web Content 
Management System (CMS), as it employs Java-based technologies. It offers a user and 
role management system with single-sign-on support as well as a built-in Web CMS which 
offers the users with the familiar features required to build websites and portals, i.e. 
an assembly of themes, pages and portlets. The portlets supported adhere to the Java 
JSR-286 portlet specification. 

-----------------------
3. Standard Visual Components
The Visual Components described in this section are developed using Web 2.0 technologies, 
like the jChartFX and JQueryUI, which are open source Javascript libraries. The map-based 
Visual Component uses the Google Maps Javascript API V3. These VCs are developed as Java 
Portlets (JSR-286 Java API). Consequently, the VC-to-VC communication is implemented as 
inter-portlet communication using the event mechanism described in JSR-286, described as 
“software application events” in the previous sections so as to distinguish them from the 
real events that the search layer returns. A portlet (VC in our case) issues an event 
that encapsulates the data that need to be sent to other VCs. The VCs that are configured 
for listening for that specific event retrieve the data from the event, process and 
illustrate them according to the VC’s designed functionality.   In this section we shall 
present the visual components we have implemented.

A List of the implemented components follows:

3.1	Search Visual Component
The user is able to query the Search Engine VC about specific words or phrases of 
interest and define some search options such as the maximum radius of the event’s 
location around the user’s current location or events within specific dates. The Search 
VC retrieves the search results in a JSON format and fires an event with these results. 
Other VCs listening for this type of event receive the search results and process them 
according to their functionality.

3.2	Event Billboard Visual Component
The Event Billboard VC displays the top ten events provided by the search engines using 
accordion widget. The sorting of the results is based on the score awarded by the search 
engine. Upon clicking an event, the accordion expands providing the full event’s details 
while it triggers the map VC to show the specific event on the map.

3.3 Event Map Visual Component
The Event Map VC features a map showing the selected event from the Event Billboard VC. 
The map moves to center around the event. Upon selecting an event, it provides the rank, 
score, location and date-time information of the event according to the classification 
returned from the Search Layer. Additionally the score of the event is visually indicated 
by its’ map marker color. The red marker indicates a low score, the yellow color a medium 
score, whereas the green color indicates a high score. The score is computed by the 
Search Layer dynamically and it relates to the search terms given of the user.

3.4	Measurements Display Visual Component
This VC displays the various measurements recorded in proximity of the event selected on 
the Event Billboard VC at the date-time of the event. The measurements come from all 
sources from thermometer sensors in the area to the crowd density virtual sensors derived 
from a camera feed (if a camera is available at the event’s location and a crowd density 
sensor has been defined for the location of the event taking place).

3.5 Media Player Visual Component
The Media Player VC provides audio and/or video playback for the clips recorded in the 
area of the selected event at the event’s date-time.

3.6 Social Data Display Visual Component
Finally, the Social Data Display VC provides the social posts/tweets, which are 
geo-located around the area of the event and are relevant to the search term/phrase used 
in the search VC.
