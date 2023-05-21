#|

以下标为x，从新设计了一个函数

|#

(define (inc n) (+ n 1))

(define (sum term a next b)
	(if (> a b)
		0
		(+ (term a) (sum term (next a) next b))
	)

)

(define (cube x) (* x x x))

(define (integral f a b n)
	(define (get-coef x)
		(cond ((= x 0) 1)
			  ((= x n) 1)
			  ((even? x) 2)
			  (else 4) 
		)
	)

	(define h (* 1.0 (/ (- b a) n)))

	(define (term x)
		(* (get-coef x) (f (+ a (* h x))))
	)

	(/ (* h (sum term 0 inc n)) 3)
)


#|

1 ]=> (integral cube 0 1 100)

;Value: .24999999999999992

1 ]=> (integral cube 0 1 1000)

;Value: .2500000000000003

|#

