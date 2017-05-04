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

type="text/css">
    .green {
        background-color:green;
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
		
		
		//get Events from datastore to add to calendar
		ArrayList<String> colors = new ArrayList<String>();
		colors.add("green");
		colors.add("purple");
		colors.add("pink");
		colors.add("red");
		colors.add("blue");
		colors.add("orange");
		
		//CalendarEvents is an ArrayList of Event Objects that supposed to be in the calendar
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
							int x = 0;
							List<Schedule> scheduleList = ObjectifyService.ofy().load().type(Schedule.class).list();
							ArrayList<String> schedules = (ArrayList<String>) pageContext.getAttribute("schedules");
							for (String s : schedules) { 
								for (Schedule e : scheduleList){
									if(e.getTitle().equals(s)){
										Long scheduleID = e.getID();
										scheduleIDList.add(scheduleID);
										e.setColor(colors.get(x));
									}
								}
								pageContext.setAttribute("schedule", s); 
								pageContext.setAttribute("color1", colors.get(x)); %>
								<p style="margin: 5px 10px 10px 10px; color:${color1}">${schedule}</p>
						<% 		
							x += 1;
							if (x > 5) {
								x = x%6;
							}
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
				ArrayList<Event> CalendarEvents = new ArrayList<Event>();
				for(int i=0; i<scheduleIDList.size();i++){
					Long id1 = scheduleIDList.get(i); 
					pageContext.setAttribute("id1", id1);
					//userSchedule = one of user's Schedules
					Schedule userSchedule = ObjectifyService.ofy().load().type(Schedule.class).filter("id", id1).first().get();
					List<Long> EventList = userSchedule.events;
					for (int j=0; j<EventList.size();j++){
						Long id2 = EventList.get(j);
						Event userEvent = ObjectifyService.ofy().load().type(Event.class).filter("id", id2).first().get();
						userEvent.setColor(userSchedule.getColor());
						CalendarEvents.add(userEvent);
					}
				}
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
				
				ArrayList<Event> calendar = new ArrayList<Event>(168);
				ArrayList<Boolean> displayTitle = new ArrayList<Boolean>(168);
				for (int i = 0; i < 168; i++) {
					calendar.add(new Event());
					displayTitle.add(false);
				}
				
				int index = 0;
				for (Event e : CalendarEvents) {
					if (thisWeek.contains(e.getDate())) {
						for (int i = 0; i < e.getDifference(); i++) {
							if (calendar.get((e.getIntStart()+i)*7 + thisWeek.indexOf(e.getDate())).getTitle().equals("")) {
								if (i == 0) {
									displayTitle.set((e.getIntStart()+i)*7 + thisWeek.indexOf(e.getDate()), true);
								}
								calendar.set((e.getIntStart()+i)*7 + thisWeek.indexOf(e.getDate()), e);
							}
						}
					}
				}
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
						<%
							int increment = 0;
							for (int j = 0; j < 24; j++) {
								String time = "";
								if (j < 10) {
									time = "0" + j + ":00";
								} else {
									time = j + ":00";
								}
								pageContext.setAttribute("currentTime", time);
								%>
								<tr><td>${currentTime}</td>
								<%
									for (int i = increment; i < (increment+7); i++) {
										if (!calendar.get(i).getTitle().equals("")) {
											if (displayTitle.get(i)) {
												pageContext.setAttribute("title", calendar.get(i).getTitle());
												pageContext.setAttribute("color", calendar.get(i).getColor());
												%>
												<td class="has-events" rowspan="1" style="background-color:${color}">
													<div class="row-fluid lecture" style="width: 99%; height: 100%;">
														<span class="title">${title}</span>
													</div>
												</td>
												<% 
											} else {
												pageContext.setAttribute("color", calendar.get(i).getColor()); %>
												<td class=" has-events" rowspan="1" style="background-color:${color}">
													<div class="row-fluid lecture" style="width: 99%; height: 100%;"></div>
												</td>
										<% 	}
										} else { %>
											<td class=" no-events" rowspan="1"></td>
									<% 	}
									}
								increment += 7; %>
								</tr>
							<% }
							%>
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