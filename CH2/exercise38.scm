(define nil '())

(define (fold-left op initial sequence) 
	(define (iter result rest)
		(if (null? rest) 
			result
        	(iter (op result (car rest))
              (cdr rest))))
	(iter initial sequence))


(define (fold-right op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(fold-right op initial (cdr sequence)))))


#|
1 ]=> (fold-right / 1 (list 1 2 3))

;Value: 3/2
(/ 1 (/ 2 (/ 3 1)))

1 ]=> (fold-left / 1 (list 1 2 3))

;Value: 1/6
(/ (/ (/ 1 1) 2) 3)


1 ]=> (fold-right list nil (list 1 2 3))

;Value: (1 (2 (3 ())))

1 ]=> (fold-left list nil (list 1 2 3))

;Value: (((() 1) 2) 3)


fold-left
(op (op (op (op init x1) x2) x3) ...xn)

fold-right
(op x1 (op x2 (op x3...(op xn init))))

(op m n) = (op n m) 交换率
还需要满足结合率

例如 
(((a0 * a1) * a2) * a3) * a4
交换
a4 * (((a0 * a1) * a2) * a3))
结合
((((a4 * a0) * a1) * a2) * a3)






|#