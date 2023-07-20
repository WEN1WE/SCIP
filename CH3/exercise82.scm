(define (scale-stream stream factor) 
	(stream-map (lambda (x) (* x factor))
		stream))


(define (random-in-range low high) 
	(let ((range (- high low)))
    	(+ low (random range))))




(define (estimate-integral P x1 x2 y1 y2)

	(define (helper trials-passed trials)
		(if (P (random-in-range x1 x2) (random-in-range y1 y2))
			(let ((new-passed (+ 1 trials-passed))
				  (new-trials (+ 1 trials))
				 )
				(cons-stream (/ new-passed new-trials) (helper new-passed new-trials))
			) 

			(let ((new-trials (+ 1 trials)))
				(cons-stream (/ trials-passed new-trials) (helper trials-passed new-trials))

			)
		)
	)



	(let ((area (* (- x2 x1) (- y2 y1))))
		(scale-stream (helper 0 0) area)
	)
)



(define (circle-test x y)
	(<= (+ (square x) (square y)) 1)
)


(define x (estimate-integral circle-test -1.0 1.0 -1.0 1.0))

(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 10000)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)

(stream-ref x 50000)





