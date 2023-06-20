(define (make-cycle x) 
	(set-cdr! (last-pair x) x) x)

(define z (make-cycle (list 'a 'b 'c)))

(define (cycle? x)
	(define (next p)
		(if (null? p)
			'()
			(cdr p)
		)
	)

	(define (helper x1 x2)
		(cond ((null? x1) false)
			  ((null? x2) false)
			  ((eq? x1 x2) true)
			  (else (helper (next x1) (next (next x2))))
		)

	)
	(helper (next x) (next (next x)))
)