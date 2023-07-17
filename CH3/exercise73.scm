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

(define (scale-stream stream factor) 
	(stream-map (lambda (x) (* x factor))
		stream))

(define (add-streams s1 s2) (stream-map + s1 s2))


(define (integral integrand initial-value dt) 
	(define int
    	(cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
								int)))
    int)


(define (RC R C dt)
	(define (helper i v0)
		(cons-stream v0
			(add-streams (scale-stream i R) 
				         (integral (scale-stream i (/ 1.0 C)) v0 dt)

			)
		)
	)
	helper
)

(define RC1 (RC 5 1 0.5))