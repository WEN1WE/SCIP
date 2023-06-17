(define rand (let ((x random-init)) 
	(lambda ()
		(set! x (rand-update x)) 
		x)))



(define rand 
	(let ((x random-init)) 

		(define (dispatch op)
			(cond ((eq? op 'generate) (set! x (rand-update x)))
				  ((eq? op 'reset) (lambda (value) (set! x value))) 

			)

		)	
		dispatch
	)

)