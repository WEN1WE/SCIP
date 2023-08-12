
(define (diagonal? last-list current)
	(if (null? last-list)
		false
		(let ((last (car last-list)))
			(let ((temp (/ (- (cdr last) (cdr current)) (- (car last) (car current)))))
				(if (or (= temp -1) (= temp 1))
					true
					(diagonal? (cdr last-list) current)
				)
			)
		)
	)
)

(define (same-row? last-list current)
	(if (null? last-list)
		false
		(let ((last (car last-list)))
			(if (= (cdr last) (cdr current))
				true
				(same-row? (cdr last-list) current)

			)
		)
	)	
)

(define (safe? last-list current)
	(and (not (same-row? last-list current)) (not (same-row? last-list current)))
)


(define (eight-queens puzzle)
	(let ((p1 (cons 1 (amb 1 2 3 4 5 6 7 8))))
		(let ((p2 (cons 2 (amb 1 2 3 4 5 6 7 8))))
			(require (safe? (list p1) p2))
			(let ((p3 (cons 3 (amb 1 2 3 4 5 6 7 8))))
				(require (safe? (list p1 p2) p3))
				(let ((p4 (cons 4 (amb 1 2 3 4 5 6 7 8))))
					(require (safe? (list p1 p2 p3) p4))
					....

				)
			)
		)
	)
)