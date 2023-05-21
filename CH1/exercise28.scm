#|
先做几个测试
测试的数字为7，随机选择的数字为3
3^6 = 729 = 1 + 7 * 104


对于查平方的地方举个例子(4, 5)

本题还使用了let来保存变量 并且561根据测试，表现为#f

|#


(define (expmod base exp m) 
	(cond ((= exp 0) 1)
          ((even? exp) (let ( 
          						(temp (expmod base (/ exp 2) m))
          					)

          					(if (nontrivial-test temp m)
          						0
          						(remainder (square temp) m)

          					)
          				    
          				) 
          )
          (else (remainder (* base (expmod base (- exp 1) m)) m)))
)



#|
1 ]=> (nontrivial-test 4 15)

;Value: #t

1 ]=> (nontrivial-test 11 15)

;Value: #t
|#

(define (nontrivial-test a n)
	(cond ((and (not (or (= a 1) (= a (- n 1)))) (= (remainder (square a) n) 1)) true)
		  (else false)
	)
)

(define (Miller-test n) 
	(define (try-it a)
		(let (
				(temp (expmod a n n))
			 )

			 (and (not (= temp 0)) (= temp a))

		)
    )
	(try-it (+ 1 (random (- n 1))))
)


(define (fast-prime? n times) 
	(cond ((= times 0) true)
		  ((Miller-test n) (fast-prime? n (- times 1))) 
		  (else false))
)


(define (prime? n)
	(fast-prime? n 10) 
)



#|

1 ]=> (prime? 3)

;Value: #t

1 ]=> (prime? 4)

;Value: #f

1 ]=> (prime? 261)

;Value: #f

1 ]=> (prime? 561)

;Value: #f
|#