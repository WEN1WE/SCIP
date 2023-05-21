(define (integral f a b n)
	(define (add-h x)
		(+ x (* 1.0 (/ (- b a) n)))
	)

	(define (get-coef x)
		(cond ((= x 0) 1)
			  ((= x n) 1)
			  ((even? x) 2)
			  (else 4) 
		)
	)

	(define (sum term a next b count)
		(if (> a b)
			0
			(+ (* (get-coef count) (term a)) (sum term (next a) next b (+ count 1)))
		)
	)

	(/ (* (sum f a add-h b 0) (/ (- b a) n)) 3)
)


(define (cube x) (* x x x))

#|


1 ]=> (integral cube 0 1 100)

;Value: .24666666666666684

1 ]=> (integral cube 0 1 1000)

;Value: .24966666666666756

|#

