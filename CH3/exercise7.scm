(define (make-simplified-withdraw balance) 
	(lambda (amount)
		(set! balance (- balance amount))
		balance))



(define (make-decrementer balance) 
	(lambda (amount)
    	(- balance amount)))


(define (make-account balance password) 
	(define (withdraw amount) 
		(if (>= balance amount)
			(begin (set! balance (- balance amount)) 
				balance)
			"Insufficient funds")) 
	(define (deposit amount)
		(set! balance (+ balance amount))
		balance)
	(define (dispatch p m)
		(if (eq? p password)
			(cond ((eq? m 'withdraw) withdraw)
			      ((eq? m 'deposit) deposit)
	              (else (error "Unknown request: MAKE-ACCOUNT"
							m)))
			(lambda (x) "Incorrect password")
		)
	)

	dispatch)



(define (make-joint account password new-password)

	(define (dispatch p m)
		(if (eq? p new-password)
			(cond ((eq? m 'withdraw) (account password 'withdraw))
			      ((eq? m 'deposit) (account password 'deposit))
	              (else (error "Unknown request: MAKE-ACCOUNT"
							m)))
			(lambda (x) "Incorrect password")
		)

	)

	dispatch


)


(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
((paul-acc 'rosebud 'withdraw) 10)
((peter-acc 'open-sesame 'withdraw) 20)
;Value: 70
















