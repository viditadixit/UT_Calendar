<!DOCTYPE html>
<html>
<%@ page import ="java.util.List" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.util.Calendar" %>
<%@ page import ="java.util.Locale" %>
<%@ page import ="java.text.*" %>
<%@ page import="utcalendar.User" %>
<%@ page import="utcalendar.Schedule" %>
<%@ page import="utcalendar.Event" %>
<%@ page import="java.util.Collections" %>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width = device-width, initial-scale=1">
<title>Calendar</title>

<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<style>

.vertical-menu {
	width: 150px;
	height: 150px;
	overflow-y: auto;
}

.vertical-menu a {
	background-color: #eee;
	color: black;
	display: block;
	padding: 12px;
	text-decoration: none;
}

.vertical-menu a:hover {
	background-color: #ccc;
}

.vertical-menu a.active {
	background-color: #4CAF50;
	color: white;
}

table.calendar {
	margin-bottom: 0;
	overflow-y: scroll;
	height: 400px;
}

table.calendar>thead>tr>th {
	text-align: center;
}

table.calendar>tbody>tr>td {
	height: 20px;
}

table.calendar>tbody>tr>td>div { //
	padding: 8px;
	height: 40px;
	overflow-y: scroll;
	display: inline-block;
	vertical-align: middle;
	float: left;
}

table.calendar>tbody>tr>td.has-events {
	color: white;
	cursor: pointer;
	padding: 0;
	border-radius: 4px;
}

table.calendar>tbody>tr>td.has-events>div {
	
	border-left: 1px solid white;
}

table.calendar>tbody>tr>td.has-events>div:first-child {
	border-left: 0;
	margin-left: 1px;
}

table.calendar>tbody>tr>td.has-events>div.practice {
	opacity: 0.7;
}

table.calendar>tbody>tr>td.conflicts>div>span.title { //
	color: red;
}

table.calendar>tbody>tr>td.max-conflicts>div {
	background-color: red;
	color: white;
}

table.calendar>tbody>tr>td.has-events>div>span {
	display: block;
	text-align: center;
}

table.calendar>tbody>tr>td.has-events>div>span a {
	color: white;
}

table.calendar>tbody>tr>td.has-events>div>span.title {
	font-weight: bold;
}

table.table-borderless>thead>tr>th, table.table-borderless>tbody>tr>td {
	border: 0;
}

.table tbody tr.hover td, .table tbody tr.hover th {
	background-color: whiteSmoke;
}
</style>
</head>
<%
	List<User> users = ObjectifyService.ofy().load().type(User.class).list();
	Long id = (Long) request.getAttribute("id");
	User u = ObjectifyService.ofy().load().type(User.class).filter("id", id).first().get();
	String idString = Long.toString(id);
	pageContext.setAttribute("name", u.getName());
	pageContext.setAttribute("email", u.getEmail());
	pageContext.setAttribute("toDoList", u.toDoList);
	pageContext.setAttribute("schedules", u.schedules);
	pageContext.setAttribute("idString", idString);
	
	int [] numEmptyCells = new int[24];
	for(int i = 0; i < numEmptyCells.length; i++){
		numEmptyCells[i] = 7;
	}
%>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">UTCalendar</a>
			</div>
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Week</a></li>
				<li><a href="#">Day</a></li>
				<li><a href="#">Month</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-center">
				<li style="text-align:center;text-indent:150px">
				<a href="#">Hello, ${name}!</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li>
					<form action="login.jsp">
						<button style ="color: #ffffff;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
						background-color: #006dcc;*background-color: #0044cc;background-image: -moz-linear-gradient(top, #0088cc, #0044cc);
						background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc));background-image: -webkit-linear-gradient(top, #0088cc, #0044cc);
						background-image: -o-linear-gradient(top, #0088cc, #0044cc);background-image: linear-gradient(to bottom, #0088cc, #0044cc);
						background-repeat: repeat-x;border-color: #0044cc #0044cc #002a80;border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
						filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
						filter: progid:DXImageTransform.Microsoft.gradient(enabled=false)"class="btn btn-default navbar-btn">Logout
						</button>
					</form>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container-fluid">

		<div class="row">
			<div class="col-sm-2">
		<%  
		List<Long> scheduleIDList = new ArrayList<Long>();
		%>
				<div class="panel panel-default" align="left">
					<div class="panel-heading" align="center">
						<h3 class="panel-title">Schedules</h3>
					</div>
					<div class="panel-body">
					</div>
					<div align="center" >
					<div class="text-center">
						<%
						ArrayList<String> colors = new ArrayList<String>();
						colors.add("green");
						colors.add("purple");
						colors.add("pink");
						colors.add("red");
						colors.add("blue");
						colors.add("orange");
						
						int x = 0;
							List<Schedule> scheduleList = ObjectifyService.ofy().load().type(Schedule.class).list();
							ArrayList<String> schedules = (ArrayList<String>) pageContext.getAttribute("schedules");
							for (String s : schedules) { 
								
								for (Schedule e : scheduleList){
									if(e.getTitle().equals(s)){
										Long scheduleID = e.getID();
										scheduleIDList.add(scheduleID);
										e.setColor(colors.get(x));
										pageContext.setAttribute("color1", colors.get(x));
									}
								}
								pageContext.setAttribute("schedule", s); %>
								<p style="margin: 5px 10px 10px 10px;color:${color1}">${schedule}</p>						
								
						<% 		
								x++;							
								if(x>5)
									x = x%6;
							}
						%>
					</div>
						<form action="addcalendar.jsp">
	  						<button type="button" class="btn btn-primary" style ="color: #ffffff;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
						background-color: #006dcc;*background-color: #0044cc;background-image: -moz-linear-gradient(top, #0088cc, #0044cc);
						background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc));background-image: -webkit-linear-gradient(top, #0088cc, #0044cc);
						background-image: -o-linear-gradient(top, #0088cc, #0044cc);background-image: linear-gradient(to bottom, #0088cc, #0044cc);
						background-repeat: repeat-x;border-color: #0044cc #0044cc #002a80;border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
						filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
						filter: progid:DXImageTransform.Microsoft.gradient(enabled=false) padding: 5px 5px; margin: 0px 0px 15px 0px"
						onclick="location.href='addcalendar.jsp?id=${idString}'">Add/Delete</button>
						</form>
					</div>
				</div>
			</div>

			<%
			
			//get Events from datastore to add to calendar
			ArrayList<Event> CalendarEvents = new ArrayList<Event>();
			Collections.sort(CalendarEvents);
			for(int i=0; i<scheduleIDList.size();i++){
				Long id1 = scheduleIDList.get(i); 
				pageContext.setAttribute("id1", id1);
				//userSchedule = one of user's Schedules
				Schedule userSchedule = ObjectifyService.ofy().load().type(Schedule.class).filter("id", id1).first().get();
				List<Long> EventList = userSchedule.events;
		/*		int y = i;
				if(i>5)
					y = y%6;
				String thisColor = colors.get(y);	*/	
				for (int j=0; j<EventList.size();j++){
					Long id2 = EventList.get(j);
					Event userEvent = ObjectifyService.ofy().load().type(Event.class).filter("id", id2).first().get();
					userEvent.setColor(userSchedule.getColor());
				//	userEvent.setColor(thisColor);
					CalendarEvents.add(userEvent);				
				}
			}
			//CalendarEvents is an ArrayList of Event Objects that supposed to be in the calendar
			
			Calendar c = Calendar.getInstance(Locale.US);
				c.set(Calendar.DAY_OF_WEEK, 1);
				int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
				ArrayList<String> times = new ArrayList<String>();
				ArrayList<String> thisWeek = new ArrayList<String>();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				for (int i = 1; i < 8; i++) {
					c.set(Calendar.DAY_OF_WEEK, i);
					Date currentDate = c.getTime();
					String[] timeComponents = c.getTime().toString().split(" ");
					times.add(timeComponents[1] + " " + timeComponents[2]);
					thisWeek.add(formatter.format(currentDate.getTime()));
				}
				pageContext.setAttribute("Sunday", times.get(0));
				pageContext.setAttribute("Monday", times.get(1));
				pageContext.setAttribute("Tuesday", times.get(2));
				pageContext.setAttribute("Wednesday", times.get(3));
				pageContext.setAttribute("Thursday", times.get(4));
				pageContext.setAttribute("Friday", times.get(5));
				pageContext.setAttribute("Saturday", times.get(6));
			%>

			<div class="col-sm-8">
				<table class="calendar table table-bordered">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th width="14%">${Sunday}</th>
							<th width="14%">${Monday}</th>
							<th width="14%">${Tuesday}</th>
							<th width="14%">${Wednesday}</th>
							<th width="14%">${Thursday}</th>
							<th width="14%">${Friday}</th>
							<th width="14%">${Saturday}</th>
						</tr>
					</thead>
					<tbody>
						<tr>

							<td>08:00</td>
							<%
								ArrayList<String> attributes1 = new ArrayList<String>();
								int numEvents = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("08:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes1.add(thisWeek.indexOf(e.getDate()) + "");
											attributes1.add(e.getTitle());
											attributes1.add(e.getDifference() + "");
											attributes1.add(e.getColor());
											numEvents += 1;
											
										}
									}
								}
							
								if (attributes1.size() == 0) {
									for (int i = 0; i < numEmptyCells[0]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									
									for (int i = 0; i < 7; i++) { 
										if ((numEvents != 0) && (Integer.parseInt(attributes1.get(0)) == i)) { 
											pageContext.setAttribute("title", attributes1.get(1));
											pageContext.setAttribute("rowSpan", attributes1.get(2));
											pageContext.setAttribute("color", attributes1.get(3));
											numEvents -= 1;
											for(int k = 0; k < Integer.parseInt(attributes1.get(2)); k++){
												numEmptyCells[k] = numEmptyCells[k] -1;
											}
											attributes1.remove(3);
											attributes1.remove(2);
											attributes1.remove(1);
											attributes1.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan}" style = "background-color:${color}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[0]>0){
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
										numEmptyCells[0] = numEmptyCells[0] - 1;
										}
									}
								}	
							%>

						</tr>
						<tr>
							<td>08:30</td>
							<%
								ArrayList<String> attributes2 = new ArrayList<String>();
								int numEvents2 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("08:30")) {
										if (thisWeek.contains(e.getDate())) {
											attributes2.add(thisWeek.indexOf(e.getDate()) + "");
											attributes2.add(e.getTitle());
											attributes2.add(e.getDifference() + "");
											attributes2.add(e.getColor());
											numEvents2 += 1;
											
										}
									}
								}
							
								if (attributes2.size() == 0) {
									for (int i = 0; i < numEmptyCells[1]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents != 0) && (Integer.parseInt(attributes2.get(0)) == i)) { 
											pageContext.setAttribute("title2", attributes2.get(1));
											pageContext.setAttribute("rowSpan2", attributes2.get(2));
											pageContext.setAttribute("color2", attributes2.get(3));
											numEvents -= 1;
											for(int k = 0; k < Integer.parseInt(attributes2.get(2)); k++){
												numEmptyCells[k+1] = numEmptyCells[k+1] -1;
											}
											attributes1.remove(3);
											attributes1.remove(2);
											attributes1.remove(1);
											attributes1.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan2}" style = "background-color:${color2}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title2}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[1]>0) {
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
										numEmptyCells[1] = numEmptyCells[1] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>09:00</td>
								<%
								ArrayList<String> attributes3 = new ArrayList<String>();
								int numEvents3 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("09:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes3.add(thisWeek.indexOf(e.getDate()) + "");
											attributes3.add(e.getTitle());
											attributes3.add(e.getDifference() + "");
											attributes3.add(e.getColor());
											numEvents3 += 1;
											
										}
									}
								}
							
								if (attributes3.size() == 0) {
									for (int i = 0; i < numEmptyCells[2]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents3 != 0) && (Integer.parseInt(attributes3.get(0)) == i)) { 
											pageContext.setAttribute("title3", attributes3.get(1));
											pageContext.setAttribute("rowSpan3", attributes3.get(2));
											pageContext.setAttribute("color3", attributes3.get(3));
											numEvents3 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes3.get(2)); k++){
												numEmptyCells[k+2] = numEmptyCells[k+2] -1;
											}
											attributes3.remove(3);
											attributes3.remove(2);
											attributes3.remove(1);
											attributes3.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan3}" style = "background-color:${color3}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title3}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[2]>0){
									%>
										<td class=" no-events" rowspan="1"></td>
									<%
									numEmptyCells[2] = numEmptyCells[2] - 1;
										}
									}
								}	
							%>

						</tr>
						<tr>
							<td>09:30</td>
									<%
								ArrayList<String> attributes4 = new ArrayList<String>();
								int numEvents4 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("09:30")) {
										if (thisWeek.contains(e.getDate())) {
											attributes4.add(thisWeek.indexOf(e.getDate()) + "");
											attributes4.add(e.getTitle());
											attributes4.add(e.getDifference() + "");
											attributes4.add(e.getColor());
											numEvents4 += 1;
											
										}
									}
								}
							
								if (attributes4.size() == 0) {
									for (int i = 0; i < numEmptyCells[3]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents4 != 0) && (Integer.parseInt(attributes4.get(0)) == i)) { 
											pageContext.setAttribute("title4", attributes4.get(1));
											pageContext.setAttribute("rowSpan4", attributes4.get(2));
											pageContext.setAttribute("color4", attributes4.get(3));
											numEvents4 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes4.get(2)); k++){
												numEmptyCells[k+3] = numEmptyCells[k+3] -1;
											}
											attributes4.remove(3);
											attributes4.remove(2);
											attributes4.remove(1);
											attributes4.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan4}" style = "background-color:${color4}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title4}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[3]>0) {
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[3] = numEmptyCells[3] - 1;
										
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>10:00</td>
								<%
								ArrayList<String> attributes5 = new ArrayList<String>();
								int numEvents5 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("10:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes5.add(thisWeek.indexOf(e.getDate()) + "");
											attributes5.add(e.getTitle());
											attributes5.add(e.getDifference() + "");
											attributes5.add(e.getColor());
											numEvents5 += 1;
											
										}
									}
								}
							
								if (attributes5.size() == 0) {
									for (int i = 0; i < numEmptyCells[4]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents5 != 0) && (Integer.parseInt(attributes5.get(0)) == i)) { 
											pageContext.setAttribute("title5", attributes5.get(1));
											pageContext.setAttribute("rowSpan5", attributes5.get(2));
											pageContext.setAttribute("color5", attributes5.get(3));
											numEvents5 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes5.get(2)); k++){
												numEmptyCells[k+4] = numEmptyCells[k+4] -1;
											}
											attributes5.remove(3);
											attributes5.remove(2);
											attributes5.remove(1);
											attributes5.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan5}" style = "background-color:${color5}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title5}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[4]>0){
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[4] = numEmptyCells[4] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>10:30</td>
								<%
								ArrayList<String> attributes6 = new ArrayList<String>();
								int numEvents6 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("10:30")) {
										if (thisWeek.contains(e.getDate())) {
											attributes6.add(thisWeek.indexOf(e.getDate()) + "");
											attributes6.add(e.getTitle());
											attributes6.add(e.getDifference() + "");
											attributes6.add(e.getColor());
											numEvents6 += 1;
											
										}
									}
								}
							
								if (attributes6.size() == 0) {
									for (int i = 0; i < numEmptyCells[5]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents6 != 0) && (Integer.parseInt(attributes6.get(0)) == i)) { 
											pageContext.setAttribute("title6", attributes6.get(1));
											pageContext.setAttribute("rowSpan6", attributes6.get(2));
											pageContext.setAttribute("color6", attributes6.get(3));
											numEvents6 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes6.get(2)); k++){
												numEmptyCells[k+5] = numEmptyCells[k+5] -1;
											}
											attributes6.remove(3);
											attributes6.remove(2);
											attributes6.remove(1);
											attributes6.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan6}" style = "background-color:${color6}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title6}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[5]>0){
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[5] = numEmptyCells[5] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>11:00</td>
								<%
								ArrayList<String> attributes7 = new ArrayList<String>();
								int numEvents7 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("11:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes7.add(thisWeek.indexOf(e.getDate()) + "");
											attributes7.add(e.getTitle());
											attributes7.add(e.getDifference() + "");
											attributes7.add(e.getColor());
											numEvents7 += 1;
											
										}
									}
								}
							
								if (attributes7.size() == 0) {
									for (int i = 0; i < numEmptyCells[6]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents7 != 0) && (Integer.parseInt(attributes7.get(0)) == i)) { 
											pageContext.setAttribute("title7", attributes7.get(1));
											pageContext.setAttribute("rowSpan7", attributes7.get(2));
											pageContext.setAttribute("color7", attributes7.get(3));
											numEvents7 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes7.get(2)); k++){
												numEmptyCells[k+6] = numEmptyCells[k+6] -1;
											}
											attributes7.remove(3);
											attributes7.remove(2);
											attributes7.remove(1);
											attributes7.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan7}" style = "background-color:${color7}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title7}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[6]>0){
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[6] = numEmptyCells[6] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>11:30</td>
								<%
								ArrayList<String> attributes8 = new ArrayList<String>();
								int numEvents8 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("11:30")) {
										if (thisWeek.contains(e.getDate())) {
											attributes8.add(thisWeek.indexOf(e.getDate()) + "");
											attributes8.add(e.getTitle());
											attributes8.add(e.getDifference() + "");
											attributes8.add(e.getColor());
											numEvents8 += 1;
											
										}
									}
								}
							
								if (attributes8.size() == 0) {
									for (int i = 0; i < numEmptyCells[7]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents8 != 0) && (Integer.parseInt(attributes8.get(0)) == i)) { 
											pageContext.setAttribute("title8", attributes8.get(1));
											pageContext.setAttribute("rowSpan8", attributes8.get(2));
											pageContext.setAttribute("color8", attributes8.get(3));
											numEvents8 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes8.get(2)); k++){
												numEmptyCells[k+7] = numEmptyCells[k+7] -1;
											}
											attributes8.remove(3);
											attributes8.remove(2);
											attributes8.remove(1);
											attributes8.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan8}" style = "background-color:${color8}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title8}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[7]>0){
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[7] = numEmptyCells[7] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>12:00</td>
								<%
								ArrayList<String> attributes9 = new ArrayList<String>();
								int numEvents9 = 0;
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("12:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes9.add(thisWeek.indexOf(e.getDate()) + "");
											attributes9.add(e.getTitle());
											attributes9.add(e.getDifference() + "");
											attributes9.add(e.getColor());
											numEvents9 += 1;
											
										}
									}
								}
							
								if (attributes9.size() == 0) {
									for (int i = 0; i < numEmptyCells[8]; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									int counter = 0;
									for (int i = 0; i < 7; i++) { 
										if ((numEvents9 != 0) && (Integer.parseInt(attributes9.get(0)) == i)) { 
											pageContext.setAttribute("title9", attributes9.get(1));
											pageContext.setAttribute("rowSpan9", attributes9.get(2));
											pageContext.setAttribute("color9", attributes9.get(3));
											numEvents9 -= 1;
											for(int k = 0; k < Integer.parseInt(attributes9.get(2)); k++){
												numEmptyCells[k+8] = numEmptyCells[k+8] -1;
											}
											attributes9.remove(3);
											attributes9.remove(2);
											attributes9.remove(1);
											attributes9.remove(0);
											
											
										%>
											<td class=" has-events" rowspan="${rowSpan9}" style = "background-color:${color9}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title9}</span>
												</div>
											</td>
									<%	
										} else if(numEmptyCells[8]>0) {
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
									numEmptyCells[8] = numEmptyCells[8] - 1;
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>12:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>13:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>13:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>14:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>14:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>15:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>15:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>

						</tr>
						<tr>
							<td>16:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							

						</tr>
						<tr>
							<td>16:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>17:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>17:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>18:00</td>
							<%
								ArrayList<String> attributes = new ArrayList<String>();
								for (Event e : CalendarEvents) {
									if (e.getStartTime().equals("18:00")) {
										if (thisWeek.contains(e.getDate())) {
											attributes.add(thisWeek.indexOf(e.getDate()) + "");
											attributes.add(e.getTitle());
											attributes.add(e.getDifference() + "");
											break;
										}
									}
								}
								
								if (attributes.size() == 0) {
									for (int i = 0; i < 7; i++) {
										%>
										<td class=" no-events" rowspan="1"></td>	
								 <% }
								} else {
									for (int i = 0; i < 7; i++) {
										if (Integer.parseInt(attributes.get(0)) == i) { 
											pageContext.setAttribute("title1", attributes.get(1));
											pageContext.setAttribute("rowSpan1", Integer.parseInt(attributes.get(2)));
										%>
											<td class=" has-events" rowspan="${rowSpan1}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title1}</span>
												</div>
											</td>
									<%	
										} else {
									%>
										<td class=" no-events" rowspan="1"></td>			
									<%
										}
									}
								}	
							%>
						</tr>
						<tr>
							<td>18:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>19:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" has-events" rowspan="${rowSpan1}">
												<div class="row-fluid lecture" style="width: 99%; height: 100%;">
													<span class="title">${title1}</span>
												</div>
											</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>19:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-2">
				<div class="panel panel-default" align="right">
					<div class="panel-heading">
						<h3 class="panel-title" align="center">To-Do List</h3>
					</div>
					<div class="panel-body">
 					</div>
 					<div align="center" >
					<div class="text-center">
						<%
							ArrayList<String> toDoList = (ArrayList<String>) pageContext.getAttribute("toDoList");
							for (String item : toDoList) { 
								pageContext.setAttribute("item", item); %>
								<p  align="left" style="margin: 5px 10px 10px 10px;">${item}
								${s}<a href="/deleteitem?id=${idString}&item=${item}" style="float: right; color:red">X</a></p>
								
						<% 		
							}
						%>
					</div>
				<form class="col=md-12 center-block" action="/todoitem">
					<input type="hidden" name="id" id="id" value="<%=idString%>" />
					<div class="form-group">
						<input type="text" name="item" id="item" class="input-group" placeHolder="New Item">
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-sm btn-default" value="Add" style ="color: #ffffff;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
						background-color: #006dcc;*background-color: #0044cc;background-image: -moz-linear-gradient(top, #0088cc, #0044cc);
						background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc));background-image: -webkit-linear-gradient(top, #0088cc, #0044cc);
						background-image: -o-linear-gradient(top, #0088cc, #0044cc);background-image: linear-gradient(to bottom, #0088cc, #0044cc);
						background-repeat: repeat-x;border-color: #0044cc #0044cc #002a80;border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
						filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
						filter: progid:DXImageTransform.Microsoft.gradient(enabled=false)">
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>

</body>
</html>