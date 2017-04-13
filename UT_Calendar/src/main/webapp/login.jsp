<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width" = device-width, initial-scale="1">
<title>Login Page</title>

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
  </div>
</nav>

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="text-center">Login</h1>
			</div>
			<div class="modal-body">
				<form class="col=md-12 center-block" action="/utcalendar">
					<div class="form-group">
						<input type="text" name="username" id="username" class="form-control input-lg" placeHolder="Username">
					</div>
					<div class="form-group">
						<input type="password" name="password" id="password" class="form-control input-lg" placeHolder="Password">
					</div>
					<div class="form-group">
							<input type="submit" class="btn btn-block btn-lg btn-warning" value="Login">
						<span><a href="#">Forgot Password</a></span>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
</body>
</html>