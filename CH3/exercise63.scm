(define (sqrt-stream x) 
	(define guesses
    	(cons-stream
     		1.0
			(stream-map (lambda (guess) (sqrt-improve guess x)) 
				        guesses)))
	guesses)


(define (pi-summands n) 
	(cons-stream (/ 1.0 n)
		(stream-map - (pi-summands (+ n 2))))) 

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))


(define (euler-transform s) 
	(let ((s0 (stream-ref s 0))  
		  (s1 (stream-ref s 1))
		  (s2 (stream-ref s 2)))

		(cons-stream (- s2 (/ (square (- s2 s1))
							  (+ s0 (* -2 s1) s2)))
					 (euler-transform (stream-cdr s)))
	)

)


(define (make-tableau transform s)
	(cons-stream s (make-tableau transform (transform s))))



(define (sqrt-stream x) 
	(cons-stream 1.0 (stream-map
						(lambda (guess) 
							(sqrt-improve guess x))
				        (sqrt-stream x))))


(sqrt-stream x)
(1 proc2) 

(proc2)

(sqrt-stream x) ---> (1 proc2) 这里执行sqrt-stream 会产生一个新的流，这样，就没有记忆性了





















