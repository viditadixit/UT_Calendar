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
	<form name="form1" id="form1" action="/newschedule">
	<input type="hidden" name="id" id="id" value="<%=idString%>" />
	<div class="container">
		<h1>New Schedule</h1>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">Schedule
					Name:</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="scheduleName" name="scheduleName"
						placeholder="Enter schedule name">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<label class="radio-inline"><input type="radio"
						name="access" value="public">public</label> <label class="radio-inline"><input
						type="radio" name="access" value="private">private</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="valid">Valid
					emails:</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="validemail" name="validemail"
						placeholder="Enter valid emails">
				</div>
			</div>

			<div id="eventsblock">
            <div class="form-inline" id="event1">
               <div class="col-sm-offset-2 col-sm-10">
                  <div class="form-group" style="padding-right: 20px;">
   				      <label for="name1">Event 1:</label><input type="text"  class="form-control" id="name1" name="name1">
                  </div>
                  <input type="date" class="form-control" id="date1" name="date1" placeholder="mm/dd/yy" style="padding-right: 10px;">
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
				<button type="submit" class="btn btn-primary pull-right" style ="color: #ffffff;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
						background-color: #006dcc;*background-color: #0044cc;background-image: -moz-linear-gradient(top, #0088cc, #0044cc);
						background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc));background-image: -webkit-linear-gradient(top, #0088cc, #0044cc);
						background-image: -o-linear-gradient(top, #0088cc, #0044cc);background-image: linear-gradient(to bottom, #0088cc, #0044cc);
						background-repeat: repeat-x;border-color: #0044cc #0044cc #002a80;border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
						filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
						filter: progid:DXImageTransform.Microsoft.gradient(enabled=false)">Create
					Schedule</button>
			</div>
			<div class="col-sm-11" style="padding-bottom: 5px">
				<button type="button" class="btn btn-primary pull-right"
					onclick="location.href='addcalendar.jsp'" style ="color: #ffffff;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
						background-color: #006dcc;*background-color: #0044cc;background-image: -moz-linear-gradient(top, #0088cc, #0044cc);
						background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0088cc), to(#0044cc));background-image: -webkit-linear-gradient(top, #0088cc, #0044cc);
						background-image: -o-linear-gradient(top, #0088cc, #0044cc);background-image: linear-gradient(to bottom, #0088cc, #0044cc);
						background-repeat: repeat-x;border-color: #0044cc #0044cc #002a80;border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
						filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0088cc', endColorstr='#ff0044cc', GradientType=0);
						filter: progid:DXImageTransform.Microsoft.gradient(enabled=false)">Cancel</button>
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
                   "  <label for='name{}'>Event {}:</label> <input type='text'  class='form-control' name='name{}'>" +
						"</div>" +
						" <input type='date' class='form-control' name='date{}'  placeholder='mm/dd/yy' style='padding-right: 10px;'>" +
                  "<div class='form-group' style='padding-left: 20px'>" +
                   "  <label for='timefrom{}'>From:</label> <input type='time' class='form-control' name='timefrom{}'>" +
                  "</div>" +
                  "<div class='form-group' style='padding-left: 30px'>" +
                   "   <label for='timeto{}'>To:</label> <input type='time' class='form-control' name='timeto{}'>" +
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