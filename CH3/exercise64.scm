(define (sqrt x tolerance)
	(stream-limit (sqrt-stream x) tolerance))

(define (sqrt-stream x) 
	(define guesses
    	(cons-stream
     		1.0
			(stream-map (lambda (guess) (sqrt-improve guess x)) 
				        guesses)))
	guesses)


(define (stream-limit s tolerance)
	(let (
			(e1 (stream-car s)) 
			(e2 (stream-car (stream-cdr s)))

		 )

		 (if (< (abs (- e1 e2)) tolerance)
		 	e2
		 	(stream-limit (stream-cdr s) tolerance)
		 )
	)
)

(define (sqrt-improve guess x) 
	(average guess (/ x guess)))

(define (average x1 x2)
	(/ (+ x1 x2) 2.0)
)
