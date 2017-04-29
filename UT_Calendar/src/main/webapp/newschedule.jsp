<%@ page import ="java.util.List" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="utcalendar.User" %>
<%@ page import="utcalendar.Schedule" %>
<%@ page import ="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width = device-width, initial-scale=1">
<title>New Schedule</title>

<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
</head>
<%
	List<User> users = ObjectifyService.ofy().load().type(User.class).list();
	Long id = Long.parseLong(request.getParameter("id"));
	User u = ObjectifyService.ofy().load().type(User.class).filter("id", id).first().get();
	String idString = Long.toString(id);
	pageContext.setAttribute("name", u.getName());
	pageContext.setAttribute("idString", idString);
%>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">UTCalendar</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><b><font color=white>Hello, ${name}!</font></b></li>
				<li>
					<form action="login.jsp">
						<button class="glyphicon glyphicon-log-out">Logout</button>
					</form>
				</li>
			</ul>
		</div>
	</nav>
	<form name="form1" id="form1" action="doNewSchedule.jsp">
	<input type="hidden" name="id" id="id" value="<%=idString%>" />
	<div class="container">
		<h1>New Schedule</h1>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">Schedule
					Name:</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="name"
						placeholder="Enter schedule name">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<label class="radio-inline"><input type="radio"
						name="optradio">public</label> <label class="radio-inline"><input
						type="radio" name="optradio">private</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="valid">Valid
					emails:</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="valid"
						placeholder="Enter valid emails">
				</div>
			</div>

			<div id="eventsblock">
            <div class="form-inline" id="event1">
               <div class="col-sm-offset-2 col-sm-10">
                  <div class="form-group" style="padding-right: 20px;">
   				      <label for="name1">Event 1:</label><input type="text"  class="form-control" id="name1" name="name1">
                  </div>
                  <input type="date" class="form-control" id="date1"   placeholder="mm/dd/yy" style="padding-right: 10px;">
                  <div class="form-group" style="padding-left: 20px">
                     <label for="timefrom1">From:</label><input type="time" class="form-control" id="timefrom1" name="timefrom1">
                  </div>
                  <div class="form-group" style="padding-left: 30px">
                     <label for="timeto2">To:</label><input type="time" class="form-control" id="timeto1" name="timeto1">
                  </div>
               </div>
            </div>
   
        </div>

			<div id="plus" class="col-sm-offset-2  col-sm-10 ">
         	<button type="button" style="btn btn-primary" onClick="addrow()">+</button>
         </div>
         
			<div class="col-sm-11" style="padding-bottom: 5px; padding-top: 10px">
				<button type="submit" class="btn btn-primary pull-right">Create
					Schedule</button>
			</div>

			<div class="col-sm-11" style="padding-bottom: 5px">
				<button type="button" class="btn btn-primary pull-right"
					onclick="location.href='addcalendar.jsp'">Cancel</button>
	</div>
	</div>
	</form>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
      
   <script language="javascript">
	var rowcount=1;
	var template="<div class='form-inline' id='event{}'>" +
               "<div class='col-sm-offset-2 col-sm-10'> " +
                "  <div class='form-group' style='padding-right: 20px;'>" +
                   "  <label for='name{}'>Event {}:</label> <input type='text'  class='form-control' id='name{}'>" +
						"</div>" +
						" <input type='date' class='form-control' id='date{}'  placeholder='mm/dd/yy' style='padding-right: 10px;'>" +
                  "<div class='form-group' style='padding-left: 20px'>" +
                   "  <label for='timefrom{}'>From:</label> <input type='time' class='form-control' id='timefrom{}'>" +
                  "</div>" +
                  "<div class='form-group' style='padding-left: 30px'>" +
                   "   <label for='timeto{}'>To:</label> <input type='time' class='form-control' id='timeto{}'>" +
                  "</div>" +
               "</div>" +
            "</div>";
				
	function addrow() {
		rowcount = rowcount + 1;
		str = template.replace(/{}/g, rowcount.toString());
		$('#eventsblock').append(str);
			
	}
	</script>
</body>
</html>