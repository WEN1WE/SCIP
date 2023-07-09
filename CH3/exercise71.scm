(define (integers-starting-from n)
	(cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 4)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)

(define (merge-weighted s1 s2 weight)
	(cond ((stream-null? s1) s2)
		  ((stream-null? s2) s1)
		  (else
		  	(let (
		  			(s1car (stream-car s1))
		  			(s2car (stream-car s2))
		  		 )

		  		(let (
		  				(w1 (weight s1car))
		  				(w2 (weight s2car))
		  			 )
		  			(cond ((<= w1 w2) 
				  	     (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
	                    ((> w1 w2) 
	                     (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight))))
		  		)
		  	)
		  )
	)
)


(define (weighted-pairs s t weight) 
	(cons-stream
	   (list (stream-car s) (stream-car t))
	   (merge-weighted
			(stream-map (lambda (x) (list (stream-car s) x)) 
				        (stream-cdr t))
	        (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
	        weight
	    )
	)
)

(define (weight-Ramanujan p)
		(let (
		   (i (car p))
		   (j (cadr p))
		 )

		 (+ (* i i i) (* j j j))

	)
)


(define (Ramanujan-pairs stream)
	(let (
			(e1 (stream-car stream))
			(e2 (stream-car (stream-cdr stream)))
		  )

			(let 
				 (
					(w1 (weight-Ramanujan e1))
					(w2 (weight-Ramanujan e2))
				 )

				 (if (= w1 w2)
				 	(cons-stream w1 (Ramanujan-pairs (stream-cdr stream)))
				 	(Ramanujan-pairs (stream-cdr stream))
				 )
			)
	)

)
(define x (Ramanujan-pairs (weighted-pairs integers integers weight-Ramanujan)))

















