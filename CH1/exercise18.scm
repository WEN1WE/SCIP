(define (double x) (+ x x)) 
(define (halve x) (/ x 2)) 

(define (even? n) 
	(= (remainder n 2) 0)
)

(define (fast-mult a b)
	(fast-mult-iter a b 0)
)

#| 
保持ab + c不变，当b = 0，返回c的值
|#

(define (fast-mult-iter a b c)
	(cond ((= b 0) c)
		((even? b) (fast-mult-iter (double a) (halve b) c))
		(else (fast-mult-iter a (- b 1) (+ c a)))
	) 
)