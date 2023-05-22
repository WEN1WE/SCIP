#|
主要要确定对应关系
|#

(define (product term a next b)
	(if (> a b)
		1
		(* (term a) (product term (next a) next b))
	)
)

(define (product-iter term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (* result (term a)))
		)
	)
	(iter a 1)
)


(define (pi-product a b) 
	(define (pi-term x)
		(if (odd? x)
			(/ (+ 1 x) (+ x 2))
			(/ (+ 2 x) (+ 1 x))
		)
	)
	(define (pi-next x)
		(+ x 1)
	)
	(* 1.0 (product pi-term a pi-next b))
)