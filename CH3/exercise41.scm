(define (make-account balance) 
	(define (withdraw amount) 
		(if (>= balance amount)
			(begin (set! balance
						(- balance amount))
               		balance)
        "Insufficient funds"))

	(define (deposit amount)
		(set! balance (+ balance amount)) 
		balance)
	(let ((protected (make-serializer))) 
		(define (dispatch m)
			(cond ((eq? m 'withdraw) (protected withdraw)) 
				  ((eq? m 'deposit) (protected deposit)) 
				  ((eq? m 'balance)
					((protected
						(lambda () balance)))) ; serialized
					(else
						(error "Unknown request: MAKE-ACCOUNT"
							m))))
		dispatch))

;A取款时候，还没完成时, B取款前查看余额，余额还是100，这时A取款完成，余额变为50，B执行取款100，
;但是这个也不能执行



