<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" />
	<style type="text/css">
		body{
			background:#f8f8f8;
			text-align:center
		}
		#content {
			width:450px;
			margin:30px auto;
			padding:30px;
			background:#fff;
			border:solid 1px #ddd;
		}
	</style>
</head>
<body>

	<h1>Charge</h1>


	<strong>Result </strong> : 


	<g:if test="${message}">
		<div class="alert alert-info">${message}</div>		
	</g:if>
	

	<h4>Transactions</h4>
	<table class="table table-bordered">
		<tr>
			<th>Id</th>
			<th>Date</th>
			<th>Amount</th>
			<th>Stripe <br/>Charge Id</th>
		</tr>
		<g:each in="${transactions}" var="transaction">
			<tr>
				<td>${transaction.id}</td>
				<td>${transaction.dateCreated}</td>
				<td>${transaction.amount}</td>
				<td>${transaction.chargeId}</td>
			</tr>
		</g:each>
	</table>

</body>
</html>