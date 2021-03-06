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
		#content a{
			margin-top:40px;
			display:inline-block;
		}
	</style>
</head>
<body>


<div id="content">
	<h1>Process Payment</h1>
	
	<g:if test="${flash.message}">
		<div class="alert alert-warning">${flash.message}</div>		
	</g:if>
	
	
	
	<form action="/transaction/charge" method="post" id="payment-form">
		<strong>Amount</strong>
		<input type="text" name="amount" value="" class="form-control"/>
		<input type="hidden" name="token" value="" id="token-input"/>
	</form>
	
	
	<div id="credit-card-information" style="padding:20px; border:solid 1px #ddd"></div>
	<div id="processing"></div>
	
	
	<a href="javascript:" class="btn btn-primary" id="submit-btn">Process Payment</a>
</div>





<script src="https://js.stripe.com/v3/"></script>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>



 <script type="text/javascript">
	$(document).ready(function(){

		var stripe = {},
    		elements = {},
    		card = {};

		var $form = $("#payment-form")
			$creditCardInfo = $("#credit-card-information")
			$processing = $("#processing"),
			$submitBtn = $("#submit-btn"),
			$tokenInput = $("#token-input")


		var processingHtml = "Processing, please wait..."
		stripe = Stripe("your publishable key");

		elements = stripe.elements()
		card = elements.create('card', {
			base : {
	    		fontSize: '23px',
	    		lineHeight: '48px'
			}
		})

		card.mount('#credit-card-information')

		card.addEventListener('change', function(event) {
	  		var displayError = document.getElementById('card-errors');
	  		if (event.error) {
	    		$processing.html(event.error.message)
				$processing.css({ "font-weight" : "bold" });
				$processing.show()
	  		} else {
	  			$processing.hide()
				$processing.css({ "font-weight" : "normal" })
				$processing.html(processingHtml)
	  		}
		});


		$submitBtn.click(function(event){
			event.preventDefault()
			$processing.show()
			/**

				Below, Stripe calls via ajax its own services to retrieve a token
				which you use to process a charge.

				stripe.createToken(card) : makes the ajax call or request to get the token
				.then
			**/
			stripe.createToken(card).then(function(result) {
				/**
					The function being called after
					createToken, gets a result object
				**/
				
				//set the token input to the token id
				$tokenInput.val(result.token.id)

				//submit the form with token and amount above
				$form.submit();
			});
		})


		//$form.submit()

	})
 </script>

</body>
</html>
