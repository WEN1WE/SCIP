(define (iterative-improve good-enough? improve)
	(lambda (v)
		(define (iter v1 v2) 
			(if (good-enough? v1 v2)
				v2
				(iter v2 (improve v2))
			)
		)
		(iter v (improve v))
	)
)

(define (average x y) 
	(/ (+ x y) 2))

(define (sqrt x) 
	(define (good-enough? v guess)
		(< (abs (- (square guess) x)) 0.001))

	(define (improve guess) 
		(average guess (/ x guess)))

	((iterative-improve good-enough? improve) 1.0)
)





(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2) 
		(< (abs (- v1 v2))
			tolerance)) 
	(define (improve v)
		(f v)
	)

	((iterative-improve close-enough? improve) 1.0)
)

(define (sqrt-fixed x)
	(fixed-point (lambda (y) (average y (/ x y))) 1.0))

#|
1 ]=> (sqrt-fixed 6)

;Value: 2.4494897427875517


|#









