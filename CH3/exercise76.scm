(define (smooth input-stream)
	(define (helper input last-value)
		(cons-stream (/ (+ (stream-car input) last-value) 2)
			         (helper (stream-cdr input) (stream-car input))
		)
	)
	(helper input-stream 0)
)


(define (make-zero-crossings input-stream last-value) 
	(cons-stream
   		(sign-change-detector
    		(stream-car input-stream)
    		last-value)
   		(make-zero-crossings
    		(stream-cdr input-stream)
    		(stream-car input-stream))))


(define zero-crossings 
	(make-zero-crossings (smooth sense-data) 0))