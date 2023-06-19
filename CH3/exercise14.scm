(define (mystery x) 
	(define (loop x y)
		(if (null? x) 
			y
			(let ((temp (cdr x))) 
				(set-cdr! x y) 
				(loop temp x))))
	(loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))

#|
1 ]=> w

;Value: (d c b a)

1 ]=> v

;Value: (a)

|#