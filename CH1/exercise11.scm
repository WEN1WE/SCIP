

(define (f-recursive n)
	(if (< n 3) 
		n	
		(+ (f-iter (- n 1))
		   (* 2 (f-recursive (- n 2)))
		   (* 3 (f-recursive (- n 3))))		
	)
)




(define (f-iter n)
	(f-iter-helper 2 1 0 n)
)
(define (f-iter-helper a b c count)
	(if (= count 0)
		c
		(f-iter-helper (+ a (* 2 b) (* 3 c)) a b (- count 1))
	)
)
		
	


