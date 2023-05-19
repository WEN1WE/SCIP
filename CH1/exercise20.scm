(define (gcd a b)
	(if (= b 0)
		a
		(gcd b (remainder a b))
	) 
)

#|

applicative-order 

(gcd 206 40)
(gcd 40 (remainder 206 40)) 
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
一共4次


normal-order
(gcd 206 40)

(gcd 40 (remainder 206 40))  一次

(gcd (remainder 206 40) 
	 (remainder 40 (remainder 206 40))  2次
)

(gcd (remainder 40 (remainder 206 40)) 
	 (remainder (remainder 206 40)) (remainder 40 (remainder 206 40))  4次
)

(gcd (remainder (remainder 206 40)) (remainder 40 (remainder 206 40))  4次
     (remainder (remainder (remainder 206 40))  (remainder (remainder 206 40)) (remainder 40 (remainder 206 40)) 7次
)

一共有18次，最后计算的时候4次，但是判断if时候，用了14次

|#