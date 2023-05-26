(define nil '())

(define (same-parity x . y)
	(define (helper items)
		(if (null? items)
			nil
			(if (or (and (odd? x) (odd? (car items))) (and (even? x) (even? (car items))))
				(cons (car items) (helper (cdr items)))
				(helper (cdr items))
			)

		)

	)
	(cons x (helper y))
)

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)