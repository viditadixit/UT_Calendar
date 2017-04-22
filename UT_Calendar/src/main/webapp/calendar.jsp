<!DOCTYPE html>
<html>
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
	background-color: #08C;
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
			<ul class="nav navbar-nav navbar-right">
				<li>
					<form action="login.jsp">
						<button class="btn btn-default navbar-btn">Logout</button>
					</form>
				</li>
			</ul>
		</div>
	</nav>


	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2">
				<div class="panel panel-default" align="left">
					<div class="panel-heading" align="center">
						<h3 class="panel-title">Schedules</h3>
					</div>
					<div class="panel-body">
					</div>
					<div align="center" style="margin-bottom: 20px;">
						<button type="button" class="btn btn-primary"
							onclick="location.href='addcalendar.jsp'">Add
							Schedule</button>
					</div>
				</div>
			</div>
			<div class="col-sm-8">
				<table class="calendar table table-bordered">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th width="14%">Sunday</th>
							<th width="14%">Monday</th>
							<th width="14%">Tuesday</th>
							<th width="14%">Wednesday</th>
							<th width="14%">Thursday</th>
							<th width="14%">Friday</th>
							<th width="14%">Saturday</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>08:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>

						</tr>
						<tr>
							<td>08:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>09:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>

						</tr>
						<tr>
							<td>09:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>10:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>10:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>11:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>11:30</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
						</tr>
						<tr>
							<td>12:00</td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
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
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
							<td class=" no-events" rowspan="1"></td>
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
							<td class=" no-events" rowspan="1"></td>
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
						<h3 class="panel-title" align="center">To Do list</h3>
					</div>
					<div class="panel-body">
						<div class="input-group">
							<input type="text" class="form-control"> <span
								class="input-group-btn">
								<button class="btn btn-primary" type="button">Add</button>
							</span>
						</div>
					</div>
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