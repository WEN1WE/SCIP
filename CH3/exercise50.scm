
#|
(stream-car
 (stream-cdr
  (stream-filter prime?
                 (stream-enumerate-interval
                  10000 1000000))))



(define (stream-enumerate-interval low high) 
	(if (> low high)
      the-empty-stream
      (cons-stream
      	low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
	(cond ((stream-null? stream) the-empty-stream)
	      ((pred (stream-car stream))
	       (cons-stream (stream-car stream)
	                      (stream-filter
	                       pred
	                       (stream-cdr stream))))
		  (else (stream-filter pred (stream-cdr stream)))))

|#

(define (stream-map proc . argstreams) 
	(if (stream-null? (car argstreams))
            the-empty-stream
			(cons-stream
				(apply proc (map stream-car argstreams)) 
				(apply stream-map
					(cons proc (map stream-cdr argstreams)))
			)
	)
)

(define x (cons-stream 1 (cons-stream 2 (cons-stream 3 '()))))
(define y (cons-stream 3 (cons-stream 2 (cons-stream 1 '()))))














