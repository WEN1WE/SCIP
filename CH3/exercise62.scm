(define (integrate-series series)
	(define (helper s i)
		(cons-stream (/ (stream-car s) i) (helper (stream-cdr s) (+ i 1)))
	)
	(helper series 1)
)

(define exp-series
	(cons-stream 1 (integrate-series exp-series)))

(define (negative series)
	(cons-stream (* -1 (stream-car series)) (negative (stream-cdr series)))
)

(define cosine-series (cons-stream 1 (negative (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))


(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 10)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)







(define (add-streams s1 s2) (stream-map + s1 s2))

(define (scale-stream stream factor) 
	(stream-map (lambda (x) (* x factor))
		stream))

(define (mul-series s1 s2)
	(cons-stream (* (stream-car s1) (stream-car s2)) 
		         (add-streams 
		         	(scale-stream (stream-cdr s2) (stream-car s1))
		         	(mul-series (stream-cdr s1) s2)
		         )
	)
)

(define (invert-unit-series series)
	(cons-stream 1 (mul-series (scale-stream (stream-cdr series) -1) (invert-unit-series series)))
)







(define (div-series s1 s2)
	(if (not (= 0 (stream-car s2)))
		(let ((invert-s2 (scale-stream (invert-unit-series (scale-stream s2 (/ 1 (stream-car s2)))) (stream-car s2))))
			(mul-series s1 invert-s2)
		)	
		(error "Can not divide 0")
	)
)


(define x (div-series sine-series cosine-series))
