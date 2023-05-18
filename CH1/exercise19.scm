(define (even? n) 
	(= (remainder n 2) 0)
)

#|
本题是用迭代的方法写的，之所以能加速，是因为找到了跳过一格的方法 a^n = (a^2)^(n/2),由于跳过了一格，问题的规模就缩小了一半，不停迭代，时间复杂度就是logn
此题需要一些代数运算，也可以用线性代数的知识来计算，更简单
|#

(define (fib n)
	(fib-iter 1 0 0 1 n)
)

(define (fib-iter a b p q count)
	(cond ((= count 0) b)
		  ((even? count) (fib-iter a 
		  		                   b 
		  		                   (+ (square p) (square q))
		  		                   (+ (square q) (* 2 p q)) 
		  		                   (/ count 2)
		    			 )
		  )
		  (else (fib-iter (+ (* b q) (* a q) (* a p))
		  				  (+ (* b q) (* a q))
		  				  p 
		  				  q
		  				  (- count 1)
		  		)

		  )

	)

)