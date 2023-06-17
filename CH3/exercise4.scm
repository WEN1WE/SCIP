(define (make-account balance password) 
	(let ((count 0))
		(define (withdraw amount) 
			(if (>= balance amount)
				(begin (set! balance (- balance amount)) 
					balance)
				"Insufficient funds")) 
		(define (deposit amount)
			(set! balance (+ balance amount))
			balance)

		(define (call-the-cops)
			"call-the-cops"
		)

		(define (dispatch p m)
			(if (eq? p password)
				(cond ((eq? m 'withdraw) withdraw)
				      ((eq? m 'deposit) deposit)
		              (else (error "Unknown request: MAKE-ACCOUNT"
								m)))
				(lambda (x) 
					(set! count (+ 1 count))
					(if (>= count 7)
						(call-the-cops)
						"Incorrect password"
					)
					
				)
			)
		)

		dispatch
	)
)