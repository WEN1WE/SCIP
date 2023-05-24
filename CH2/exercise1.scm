(define (make-rat n d) 
	(let ((g (gcd n d)))
		(if (< d 0)
			(cons (- (/ n g)) (- (/ d g))) 
			(cons (/ n g) (/ d g))
		)	
	)
)

#|
1 ]=> (cdr (make-rat 10 -12))

;Value: 6

1 ]=> (car (make-rat 10 -12))

;Value: -5


|#
