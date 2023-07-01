
(define (count)
	(let ((n 0))
		(lambda () 
			n
			(set! n (+ n 1))
		)
	)
)

(define id (count))



(define (make-account-and-serializer balance) 
	(let ((n (id)))
		(define (withdraw amount)
			(if (>= balance amount)
				(begin (set! balance (- balance amount))
	               balance)
	        "Insufficient funds"))
		(define (deposit amount)
			(set! balance (+ balance amount)) 
			balance)

		(let ((balance-serializer (make-serializer))) 
				
			(define (dispatch m)
				(cond ((eq? m 'withdraw) withdraw)
					  ((eq? m 'deposit) deposit)
					  ((eq? m 'balance) balance)
					  ((eq? m 'id) n)
					  ((eq? m 'serializer) balance-serializer)
					  (else (error "Unknown request: MAKE-ACCOUNT" m))))
			dispatch)
	)
)


(define (deposit account amount) 
	(let ((s (account 'serializer))
        (d (account 'deposit)))
      ((s d) amount)))


(define (exchange account1 account2)
	(let ((difference (- (account1 'balance)
                       (account2 'balance))))
    	((account1 'withdraw) difference)
    	((account2 'deposit) difference)))

(define (bigger account1 account2)
	(if (> (account1 'id) (account2 'id))
		account1 
		account2
	)
)

(define (smaller account1 account2)
	(if (< (account1 'id) (account2 'id))
		account1 
		account2
	)
)

(define (serialized-exchange account1 account2) 
	(let ((serializer1 ((smaller account1 account2) 'serializer))
        (serializer2 ((bigger account1 account2) 'serializer)))

	    ((serializer1 (serializer2 exchange))
	     account1
	     account2)
    )
)


; 由于按照顺序获得mutex, 则当一个程序获得mutex时，另一个程序阻塞，这样就不会出现死锁








