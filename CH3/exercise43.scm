(define (make-account-and-serializer balance) 
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
				  ((eq? m 'serializer) balance-serializer)
				  (else (error "Unknown request: MAKE-ACCOUNT" m))))
		dispatch))


(define (deposit account amount) 
	(let ((s (account 'serializer))
        (d (account 'deposit)))
      ((s d) amount)))


(define (exchange account1 account2)
	(let ((difference (- (account1 'balance)
                       (account2 'balance))))
    	((account1 'withdraw) difference)
    	((account2 'deposit) difference)))


(define (serialized-exchange account1 account2) 
	(let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))

	    ((serializer1 (serializer2 exchange))
	     account1
	     account2)
    )
)





(a)
; 如果顺序进行，钱仅仅交换到了账户，钱则一直都是10 20 30

; 如果并行执行

(exchange account1 account2)

account1 10
account2 20

difference -10

                          (exchange account1 account3)
							交换完成后
							account1 30 
							account3 10

account1 30-(-10) = 40
account2 20+(-10) = 10


(b)

; 如果在交换钱的过程中，两个账户的钱发生改变，但是最后钱会加到一个账户，会从一个账户减掉，这样总钱数就不变


(c)

; 如果单个账户的串行也没有实现，则

(exchange account1 account2)

account1 10
account2 20

difference -10

account1
get1-new = 20

                         (exchange account1 account3)
							交换完成后
							account1 30 
							account3 10


account2 20+(-10) = 10

set1-new = 20

; 由于没有实现串行，设置可以在最后进行，则最后账户余额为20 10 10 






























