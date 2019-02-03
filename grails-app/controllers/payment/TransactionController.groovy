package payment

import com.stripe.Stripe
import com.stripe.model.Charge

import org.payment.Transaction

class TransactionController {
	

	def index(){}


	def charge(){

		if(!params.amount){
			flash.message = "Please set an amount"
			redirect(action: "index")
			return
		}

 	   	BigDecimal amount = new BigDecimal(params.amount);
		amount  = amount.setScale(2, BigDecimal.ROUND_HALF_UP);

		def token = params.token

		Stripe.apiKey = "sk_test_4dQF1CReWZfRQG8tAEKVBPlg"
		def amountInCents = (amount * 100) as Integer


		def transaction = new Transaction()
		transaction.amount = amount
		transaction.save(flush:true)


		def chargeParams = [
		    'amount':      amountInCents, 
		    'currency':    "usd", 
		    'source':       token, 
		    'description': "Order Placed"
		]

		def charge = Charge.create(chargeParams)
			
		def message
		if(charge){
			transaction.chargeId = charge.id
			transaction.save(flush:true)
			message = "Successfully charged ${charge.id} : ${transaction.id}"
		}else{
			transaction.delete(flush:true)
			message = "Something went wrong"
		}

		[ message : message, transactions: Transaction.list() ]

	}

}
