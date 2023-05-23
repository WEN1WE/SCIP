(define (compose f g)
	(lambda (x) (f (g x)))  
)

(define (repeated f n)
	(if (= 1 n)
		f
		(compose f (repeated f (- n 1))) 
	)
)

#|
1 ]=> ((repeated square 2) 5)

;Value: 625


|#