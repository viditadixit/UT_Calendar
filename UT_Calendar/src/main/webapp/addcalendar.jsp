<!DOCTYPE html>
<html>

<%@ page import ="java.util.List" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="utcalendar.User" %>
<%@ page import="utcalendar.Schedule" %>
<%@ page import ="java.util.List" %>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Calendar</title>

<style>
{
box-sizing
:
 
border-box
;


}
#myInput {
	background-image: url('/css/searchicon.png');
	background-position: 10px 10px;
	background-repeat: no-repeat;
	width: 100%;
	font-size: 16px;
	padding: 12px 20px 12px 40px;
	border: 1px solid #ddd;
	margin-bottom: 12px;
}

#myTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 18px;
	display:none;
}

#myTable th, #myTable td {
	text-align: left;
	padding: 12px;
}

#myTable tr {
	border-bottom: 1px solid #ddd;
}

#myTable tr.header, #myTable tr:hover {
	background-color: #f1f1f1;
}
</style>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

</head>
<%
	ObjectifyService.register(User.class);
	ObjectifyService.register(Schedule.class);
	List<User> users = ObjectifyService.ofy().load().type(User.class).list();
	Long id = Long.parseLong(request.getParameter("id"));
	User u = ObjectifyService.ofy().load().type(User.class).filter("id", id).first().get();
	String idString = Long.toString(id);
	pageContext.setAttribute("name", u.getName());
	pageContext.setAttribute("idString", idString);
	String selectedSchedules = "test";
%>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">UTCalendar</a>
			</div>
			<ul class="nav navbar-nav">
				<li><b><font color=white>Hello, ${name}!</font></b></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><span class="glyphicon glyphicon-log-out"></span>
						Logout</a></li>
			</ul>
		</div>
	</nav>
	
	<%
	//Table consists of Schedules from datastore
	List<Schedule> schedules = ObjectifyService.ofy()
		.load()
		.type(Schedule.class)
		.list();
	%>

	<div class="container">
		<h1>Add Schedules</h1>
		<p>Search for schedule to add</p>
		<input type="text" id="myInput" onkeyup="myFunction()"
			placeholder="Search for schedules.." title="Type in a name">

		<table id="myTable">
			<tr class="header">
				<th style="width: 60%;">Schedule</th>
				<th style="width: 30%;">Author</th>
				<th style="width: 10%;"></th>
			</tr>
			<%
			for(int i=0; i<schedules.size();i++){
				pageContext.setAttribute("title",schedules.get(i).getTitle());
				String name=u.getName();
				pageContext.setAttribute("author", name);
				out.write(schedules.get(i).getTitle());
				%>
				<tr>
				<td>${title}</td> 
				<td>${author}</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Course Schedules')">Add</a> </td>
			</tr>
			
			<%
			}
			%>
			<tr>
				<td>Course Schedules</td>
				<td>Katelyn Ge</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Course Schedules')">Add</a> </td>
			</tr>
			<tr>
				<td>WECE Social Calendar</td>
				<td>Vidita Dixit</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'WECE Social Calendar')">Add</a> </td>
			</tr>
			<tr>
				<td>Theta Tau Events</td>
				<td>Kirtana Moorthy</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Theta Tau Events')">Add</a> </td>
			</tr>
			<tr>
				<td>SEEK Calendar</td>
				<td>Rebecca Jiang</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'SEEK Calendar')">Add</a> </td>
			</tr>
			<tr>
				<td>Office Fan Club</td>
				<td>Katelyn Ge</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Office Fan Club')">Add</a> </td>
			</tr>
			<tr>
				<td>Brooklyn 99 Fan Club</td>
				<td>Kirtana Moorthy</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Brooklyn 99 Fan Club')">Add</a> </td>
			</tr>
			<tr>
				<td>Liars Club</td>
				<td>Gunalan Karun</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Liars Club')">Add</a> </td>
			</tr>
			<tr>
				<td>Is There A Quiz Today</td>
				<td>Irfan Hasan</td>
				<td><a href="javascript:void(0)" onclick="addSchedule(1,'Is There A Quiz Today')">Add</a> </td>
			</tr>
		</table>

		<div id="mySchedule">
		</div>
		
		<script>
			function myFunction() {
				
				var input, filter, table, tr, td, i;
				input = document.getElementById("myInput");
				filter = input.value.toUpperCase();
				table = document.getElementById("myTable");
				tr = table.getElementsByTagName("tr");
				for (i = 0; i < tr.length; i++) {
					td = tr[i].getElementsByTagName("td")[0];
					if (td) {
						if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
							tr[i].style.display = "";
						} else {
							tr[i].style.display = "none";
						}
					}
				}
				if(input.value=="" || input.value=="Search for schedules.."){
					$("#myTable").hide();
				}
				else{ 
					$("#myTable").show();
				}
				
			}
			function addSchedule(scheduleID, scheduleName){
				content=$("#mySchedule").html()+"<br>"+scheduleName;
				$("#mySchedule").html(content);
				
				//send request to server, add ID
				/*$.ajax({
					  url: "doAddSchedule.jsp?id="+scheduleID,
					}).done(function( data ) {
						  content=$("#mySchedule").html()+"<br>"+scheduleName;
							$("#mySchedule").html(content);
					  }); */
			}
		</script>

		<form class="col=md-12 center-block" action="newschedule.jsp">
  			<input type="hidden" name="id" id="id" value="<%=idString%>" />
			<div class="col-sm-11" style="padding-bottom: 5px; padding-left: 50px">
			<div class="form-group">
				<input type="submit" class="btn btn-primary pull-left" value="Create New Schedule">
			</div>
			</div>
		</form>
		

		
		<form class="col=md-12 center-block" action="/addschedule">
  			<input type="hidden" name="schedules" id="schedules" value=<%=selectedSchedules%> />
  			<input type="hidden" name="id" id="id" value="<%=idString%>" />
			<div class="col-sm-11" style="padding-bottom: 5px; padding-left: 50px">
			<div class="form-group">
				<input type="submit" class="btn btn-primary pull-left" value="Back To Calendar">
			</div>
			</div>
		</form>

	</div>
</body>



</html>