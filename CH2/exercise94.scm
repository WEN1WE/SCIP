(define p1 (make-polynomial
	'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1)))) 
(greatest-common-divisor p1 p2)

(define (div-terms L1 L2) 
	(if (empty-termlist? L1)
		(list (the-empty-termlist) (the-empty-termlist)) 

		(let ((t1 (first-term L1))
			 (t2 (first-term L2)))

			(if (> (order t2) (order t1))
				(list (the-empty-termlist) L1)

				(let ((new-c (div (coeff t1) (coeff t2)))
  					 (new-o (- (order t1) (order t2)))) 
				  (let ((rest-of-result
						(sub L1 (mul (adjoin-term (make-term new-o new-c) (the-empty-termlist)) L2)))) 

				      (let ((next (div-terms rest-of-result L2)))
				      	 (list (adjoin-term (make-term new-o new-c) (car next)) (cadr next))

				      )

				  )
				)
			)
		)
	)

)  


(define (gcd-terms a b) (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (remainder-terms a b)
	(cadr (div-terms a b))
)


(define (gcd-poly p1 p2)
	(if (= (variable p1) (variable p2))
		(let ((t1 (term-list p1))
			  (t2 (term-list p2))
			 )
		     (make-polynomial (variable p1) (gcd-terms t1 t2))

		)
		(error "Polys not in same var: ADD-POLY" (list p1 p2)
	)
)

(define (greatest-common-divisor p1 p2)
	(apply-genaric 'greatest-common-divisor p1 p2)
)

 (put 'greatest-common-divisor '(scheme-number scheme-number) 
      (lambda (a b) (gcd a b))) 

 (put 'greatest-common-divisor '(polynomial polynomial) 
      (lambda (a b) (tag (gcd-poly a b)))) 














