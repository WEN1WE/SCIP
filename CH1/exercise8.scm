(define (improve guess x)
	(/
		(+ (/ x 
			  (* guess guess))
		   (* 2 guess))
		3))

(define (good-enough? guess-old guess-new)
	(< (/ (abs (- guess-new guess-old)) guess-old) 0.001))

(define (cusq-iter guess-old guess-new x)
	(if (good-enough? guess-old guess-new)
		guess-new
		(cusq-iter guess-new (improve guess-new x) x)))

(define (cusq x)
	(cusq-iter 1.0 (* 1.0 x) (* 1.0 x)))