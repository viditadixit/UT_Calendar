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


			<div class="form-inline">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="form-group" style="padding-right: 20px;">

						<label for="name">Event 1:</label> <input type="text"
							class="form-control" id="name">
					</div>

					<input type="date" class="form-control" id="date"
						placeholder="mm/dd/yy" style="padding-right: 10px;">
					<div class="form-group" style="padding-left: 20px">

						<label for="time">From:</label> <input type="time"
							class="form-control" id="time">
					</div>
					<div class="form-group" style="padding-left: 30px">

						<label for="time">To:</label> <input type="time"
							class="form-control" id="time">
					</div>
				</div>
			</div>

			<div class="form-inline">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="form-group" style="padding-right: 20px;">

						<label for="name">Event 2:</label> <input type="text"
							class="form-control" id="name">
					</div>

					<input type="date" class="form-control" id="date"
						placeholder="mm/dd/yy" style="padding-right: 10px;">
					<div class="form-group" style="padding-left: 20px">

						<label for="time">From:</label> <input type="time"
							class="form-control" id="time">
					</div>
					<div class="form-group" style="padding-left: 30px">

						<label for="time">To:</label> <input type="time"
							class="form-control" id="time">
					</div>
				</div>
			</div>

			<div class="form-inline">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="form-group" style="padding-right: 20px;">

						<label for="name">Event 3:</label> <input type="text"
							class="form-control" id="name">
					</div>

					<input type="date" class="form-control" id="date"
						placeholder="mm/dd/yy" style="padding-right: 10px;">
					<div class="form-group" style="padding-left: 20px">

						<label for="time">From:</label> <input type="time"
							class="form-control" id="time">
					</div>
					<div class="form-group" style="padding-left: 30px">

						<label for="time">To:</label> <input type="time"
							class="form-control" id="time">
					</div>
				</div>
			</div>

			<div class="form-inline">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="form-group" style="padding-right: 20px;">

						<label for="name">Event 4:</label> <input type="text"
							class="form-control" id="name">
					</div>

					<input type="date" class="form-control" id="date"
						placeholder="mm/dd/yy" style="padding-right: 10px;">
					<div class="form-group" style="padding-left: 20px">

						<label for="time">From:</label> <input type="time"
							class="form-control" id="time">
					</div>
					<div class="form-group" style="padding-left: 30px">

						<label for="time">To:</label> <input type="time"
							class="form-control" id="time">
					</div>
				</div>
			</div>

			<div class="form-inline">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="form-group" style="padding-right: 20px;">
						<label for="name">Event 5:</label> <input type="text"
							class="form-control" id="name">
					</div>

					<input type="date" class="form-control" id="date"
						placeholder="mm/dd/yy" style="padding-right: 10px;">
					<div class="form-group" style="padding-left: 20px">

						<label for="time">From:</label> <input type="time"
							class="form-control" id="time">
					</div>
					<div class="form-group" style="padding-left: 30px">

						<label for="time">To:</label> <input type="time"
							class="form-control" id="time">
					</div>
				</div>

			</div>

			<div class="col-sm-11" style="padding-bottom: 5px; padding-top: 10px">
				<button type="submit" class="btn btn-primary pull-right">Create
					Schedule</button>
			</div>

			<div class="col-sm-11" style="padding-bottom: 5px">
				<button type="submit" class="btn btn-primary pull-right"
					onclick="location.href='addcalendar.jsp'">Cancel</button>
	</div>
	</div>



	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
</body>
</html>