
(define (fast-expt b n)
	(fast-expt-iter b n 1)
)


#|
这个程序中保留了一个不变量 就是ab^n 每次迭代过程中，都保持不变，最后需要n=0，然后返回a的值，就是我们所求的


|#
(define (fast-expt-iter b n a)
	(cond ((= n 0) a)
		  ((even? n) (fast-expt-iter (square b) (/ n 2) a))
		  (else (fast-expt-iter b (- n 1) (* b a)))

	)

)

(define (even? n) 
	(= (remainder n 2) 0)
)