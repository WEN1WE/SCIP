#|
561, 1105, 1729, 2465, 2821, and 6601

|#


(define (expmod base exp m) 
	(cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else (remainder (* base (expmod base (- exp 1) m)) m)))
)

(define (fermat-test n a) 
	(= (expmod a n n) a)
)

(define (fast-prime? n a) 
	(cond ((= a 0) true)
		  ((fermat-test n a) (fast-prime? n (- a 1))) 
		  (else false))
)

(define (prime? n)
	(fast-prime? n (- n 1)) 
)


#|
1 ]=> (prime? 561)

;Value: #t

1 ]=> (prime? 4)  

;Value: #f

1 ]=> (prime? 1105)

;Value: #t

1 ]=> (prime? 1729)

;Value: #t

1 ]=> (prime? 2465)

;Value: #t

1 ]=> (prime? 2821)

;Value: #t

1 ]=> (prime? 6601)

;Value: #t



|#

