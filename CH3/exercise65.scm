(define (add-streams s1 s2) (stream-map + s1 s2))

(define (partial-sums s)
	(cons-stream (stream-car s) (add-streams (partial-sums s) (stream-cdr s)))
)

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



(define (euler-transform s) 
	(let ((s0 (stream-ref s 0))  
		  (s1 (stream-ref s 1))
		  (s2 (stream-ref s 2)))

		(cons-stream (- s2 (/ (square (- s2 s1))
							  (+ s0 (* -2 s1) s2)))
					 (euler-transform (stream-cdr s)))
	)

)



(define (log2-summands n) 
	(cons-stream (/ 1.0 n)
		(stream-map - (log2-summands (+ n 1))))) 


(define log2-stream
  (partial-sums (log2-summands 1)))


(define s1 (euler-transform log2-stream))
(define s2 (euler-transform s1))
(define s3 (euler-transform s2))


(define (make-tableau transform s)
	(cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s) (stream-map stream-car (make-tableau transform s)))

(define x (accelerated-sequence euler-transform log2-stream))
















