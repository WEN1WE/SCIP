(define (pow x y)
	(if (= y 0)
		1
		(* x (pow x (- y 1))) 
	)
)




(define (cons x y)
	(* (pow 2 x) (pow 3 y))
)

(define (car z)
	(if (= 0 (remainder z 2))
		(+ 1 (car (/ z 2)))
		0 
	)
)

(define (cdr z)
	(if (= 0 (remainder z 3))
		(+ 1 (cdr (/ z 3)))
		0 
	)
)


#|
1 ]=> (cdr (cons 1 4))

;Value: 4

1 ]=> (car (cons 1 4))

;Value: 1

(expt 2 3) 可以实现　pow ，系统自带
|#

