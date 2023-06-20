(define (make-cycle x) 
	(set-cdr! (last-pair x) x) x)

(define z (make-cycle (list 'a 'b 'c)))


(define (cycle? x)
	(let ((visited '()))
		(define (helper p)
			(if (null? p)
				false
				(if (memq p visited)
					true
					(begin (set! visited (cons p visited))
						   (helper (cdr p))
					)
				)
			)
		)
		(helper x)
	)
)