(define (segments->painter segment-list) 
	(lambda (frame)
		(for-each
			(lambda (segment)
       			(draw-line
	        		((frame-coord-map frame)
	         		(start-segment segment))

	        		((frame-coord-map frame)
	         		(end-segment segment))
         		)
         	)

            segment-list
        )
	)
)

(define (make-segment v1 v2)
	(cons v1 v2)
)

(define (start-segment seg)
	(car seg)
)

(define (end-segment seg)
	(cdr seg)
)






