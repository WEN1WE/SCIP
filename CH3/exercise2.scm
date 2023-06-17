(define (make-monitored f)
	(let ((counter 0))
		(define (dispatch m)
			(cond ((eq? m 'how-many-calls?) counter)
				  ((eq? m 'reset-count) (set! counter 0))
				  (else (set! counter (+ 1 counter)) (f m))
			)
		)
		dispatch
	)
)


