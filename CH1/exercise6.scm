
(define (sqrt-iter guess x) 
	(if (good_enough? guess x)
    	guess
    	(sqrt-iter (improve guess x) x)))

(define (improve guess x) 
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

#|
(define (good_enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

|#


(define (sqrt x)
	(sqrt-iter 1.0 x))


#|
(define (new-if predicate then-clause else-calse)
	(cond (predicate then-clause)
		  (else else-calse))) 
|#

