(define (expand num den radix) 
	(cons-stream
         (quotient (* num radix) den)
         (expand (remainder (* num radix) den) den radix)))


3 8 10
(expend 3 8 10)
(3 (expend 6 8 10))
(7 (expend 4 8 10))
(5 (expend 0 8 10))
(0 (expend 0 8 10))

1 7 10
(expend 1 7 10)
(1 (expend 3 7 10))
(4 (expend 2 7 10))
(2 (expend 6 7 10))
(8 (expend 4 7 10))
(5 (expend 5 7 10))
(7 (expend 1 7 10))