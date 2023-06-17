(define new-withdraw 
	(let ((balance 100))
		(lambda (amount)
			(if (>= balance amount)
				(begin (set! balance (- balance amount)) balance)
          "Insufficient funds"))))




(define (make-withdraw balance) 
	(lambda (amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))


(define (make-account balance) 
	(define (withdraw amount) 
		(if (>= balance amount)
			(begin (set! balance (- balance amount)) 
				balance)
			"Insufficient funds")) 
	(define (deposit amount)
		(set! balance (+ balance amount))
		balance)
	(define (dispatch m)
		(cond ((eq? m 'withdraw) withdraw)
			  ((eq? m 'deposit) deposit)
	          (else (error "Unknown request: MAKE-ACCOUNT"
							m))))
	dispatch)


(define (make-accumulator sum)
	(lambda (n)
		(set! sum (+ sum n))
		sum
	)
)

#|
1 ]=> (define A (make-accumulator 5))

;Value: a

1 ]=> (A 10)

;Value: 15

1 ]=> (A 10)

;Value: 25



|#























