

#|
(define rand
	(let ((x random-init))
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


(define random-numbers 
	(cons-stream
   		random-init
  		(stream-map rand-update random-numbers)))

|#

(define random-init 1)

(define (reset-random reqest-stream)

	(define (gen-numbers first)
		(define numbers
			(cons-stream first 
				         (stream-map rand-update numbers))
		)
		numbers
	)


	(define (helper reqests randoms)
		(let ((op (stream-car reqests)))
			(cond 

			  ((eq? (car op) 'generate)
				(cons-stream (stream-car (stream-cdr randoms)) 
					         (helper (stream-cdr reqests) (stream-cdr randoms)))
			  )

			  ((eq? (car op) 'reset)
			  	(cons-stream (cadr op) (helper (stream-cdr reqests) (gen-numbers (cadr op))))

			  )
			)
	    )
	)

	(helper reqest-stream (gen-numbers random-init))
)






(define test (stream  
      '(generate) 
      '(generate) 
      '(generate) 
      '(reset 2020) 
      '(generate) 
      '(generate) 
      '(reset 1234) 
      '(generate) 
      '(generate)))









#|

(define cesaro-stream 
	(map-successive-pairs
		(lambda (r1 r2) (= (gcd r1 r2) 1))
		random-numbers))


(define (map-successive-pairs f s)
  (cons-stream
  		(f (stream-car s) (stream-car (stream-cdr s)))
   		(map-successive-pairs f (stream-cdr (stream-cdr s)))))


(define (monte-carlo experiment-stream passed failed) 
	(define (next passed failed)
    	(cons-stream
     		(/ passed (+ passed failed))
     		(monte-carlo
				(stream-cdr experiment-stream) passed failed))) 
	(if (stream-car experiment-stream)
      	(next (+ passed 1) failed)
		(next passed (+ failed 1)))) 


(define pi
	(stream-map
		(lambda (p) (sqrt (/ 6 p))) 
		(monte-carlo cesaro-stream 0 0)))



|#













