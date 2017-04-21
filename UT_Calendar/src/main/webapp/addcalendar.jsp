<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width" = device-width, initial-scale=1">
<title>Add Calendar</title>

<link rel="stylesheet" type="text/css" href="addcalendar.css" />
<link rel="stylesheet" type="text/css" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
</head>

<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">UTCalendar</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><span class="glyphicon glyphicon-log-out"></span>
						Logout</a></li>
			</ul>
		</div>
	</nav>

<div class="container">
		<h1>Add Schedules</h1>
		<p>Select the schedule you want to add from the dropdown menu</p>
		<div class="row">
			<div class="col-md-12">
				<div class="input-group" id="adv-search">
					<input type="text" class="form-control"
						placeholder="Search for schedules" />
					<div class="input-group-btn">
						<div class="btn-group" role="group">
							<div class="dropdown dropdown-lg">
								<button type="button" class="btn btn-default dropdown-toggle"
									data-toggle="dropdown" aria-expanded="false">
									<span class="caret"></span>
								</button>
								<div class="dropdown-menu dropdown-menu-right" role="menu">
									<form class="form-horizontal" role="form">
										<div class="form-group">
											<label for="filter">Filter by</label> <select
												class="form-control">
												<option value="0" selected>All Options</option>
												<option value="1">Course Schedule</option>
												<option value="2">Extra Curriculars</option>
												<option value="3">UT Events</option>
												<option value="4">Most Popular</option>
											</select>
										</div>
										<div class="form-group">
											<label for="contain">Organization</label> <input
												class="form-control" type="text" />
										</div>
										<div class="form-group">
											<label for="contain">Contains the words</label> <input
												class="form-control" type="text" />
										</div>
										<button type="submit" class="btn btn-primary">
											<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
										</button>
									</form>
								</div>
							</div>
							<button type="button" class="btn btn-primary">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
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