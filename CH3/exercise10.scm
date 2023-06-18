(define (make-withdraw initial-amount) 
	(let ((balance initial-amount))
		(lambda (amount)
			(if (>= balance amount)
				(begin (set! balance (- balance amount)) 
					balance)
				"Insufficient funds"))))



(define (make-withdraw initial-amount)
	(
		(lambda (balance) 
			(lambda (amount)
				(if (>= balance amount)
					(begin (set! balance (- balance amount)) 
						balance)
					"Insufficient funds")
			)
		)   
		initial-amount
	)
)


(define W1 (make-withdraw 100))

                ----------------------------------
				|                                |
global env  :   | make-withdraw:                 |
                | w1                             |
                |                                |



   make-withdraw: parameters: initial-amount
   body: 

   	(
		(lambda (balance) 
			(lambda (amount)
				(if (>= balance amount)
					(begin (set! balance (- balance amount)) 
						balance)
					"Insufficient funds")
			)
		)   
		initial-amount
	)


    w1 :parameters: amount
    body: (if (>= balance amount)
              (begin (set! balance (- balance amount))
                    balance)
             "insufficient funds")






    E1 : initial-amount 100

    (
		(lambda (balance) 
			(lambda (amount)
				(if (>= balance amount)
					(begin (set! balance (- balance amount)) 
						balance)
					"Insufficient funds")
			)
		)   
		initial-amount
	)


	E2: balance : 100

	(lambda (amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount)) 
				balance)
			"Insufficient funds")
	)


	E3 : amount: 50

	(if (>= balance amount)
		(begin (set! balance (- balance amount)) 
			balance)
		"Insufficient funds")

; 根原来程序相比，对了一个环境







