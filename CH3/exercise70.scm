(define (integers-starting-from n)
	(cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 100)
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

(define (weight1 p)
	(+ (car p) (cadr p))
)

(define pairs1 (weighted-pairs integers integers weight1))


(define (divisible? i)
	(not (or (= (remainder i 2) 0) (= (remainder i 3) 0) (= (remainder i 5) 0)))
)

(define new-int (stream-filter divisible? integers))

(define (weight2 p)
	(let (
		   (i (car p))
		   (j (cadr p))
		 )

		 (+ (* 2 i) (* 3 j) (* 5 i j))

	)
)

(define pairs2 (weighted-pairs new-int new-int weight2))






