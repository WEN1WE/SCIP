(define (sqrt x)
	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001)) 
	(define (improve guess)
		(average guess (/ x guess))) 
	(define (sqrt-iter guess)
		(if (good-enough? guess) 
			guess
        	(sqrt-iter (improve guess))))
    (sqrt-iter 1.0))


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
			  (else
           		(error "Unknown request: MAKE-ACCOUNT"
                  m))))
	dispatch)


E1 balance : 50

	(define  )
	(define ...)


E2 m : 'deposit
	(cond ((eq? m 'withdraw) withdraw) 
	  ((eq? m 'deposit) deposit) 
	  (else
   		(error "Unknown request: MAKE-ACCOUNT"
          m)))

E3 amount: 40
   90


E4 m : 'withdraw
	(cond ((eq? m 'withdraw) withdraw) 
	  ((eq? m 'deposit) deposit) 
	  (else
   		(error "Unknown request: MAKE-ACCOUNT"
          m)))

E5 amount: 60
  30


; 代码部分相同，但是指针部分不同














