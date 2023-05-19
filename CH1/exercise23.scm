#|

可以看出，改进后的程序并没有达到2倍的水平，可能next函数的执行，每次也消耗了时间


|#


(define (smallest-divisor n)
	(find-divisor n 2)
)

(define (next n) 
	(if (= n 2)
		3
		(+ 2 n)
	)
)

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (next test-divisor)))
	) 
)

(define (divides? a b)
	(= (remainder b a) 0) 
)

(define (prime? n)
	(= n (smallest-divisor n)))



(define (runtime) (real-time-clock))

(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (runtime)))

(define (start-prime-test n start-time) 
	(if (prime? n)
		(report-prime (- (runtime) start-time)))) 

(define (report-prime elapsed-time)
	(display " *** ")
    (display elapsed-time))

(define (search-for-primes range) 
	(if (odd? range)                                     ;;;保证只在奇数的地方检测
		 (search-for-primes-helper (+ range 2) 3)    
		 (search-for-primes-helper (+ range 1) 3) 
	)
)


(define (search-for-primes-helper n left) 
	(cond ((> left 0) 
				(cond ((prime? n) (timed-prime-test n) (search-for-primes-helper (+ n 2) (- left 1))) 
                      (else (search-for-primes-helper (+ n 2) left))

				)
		  )		            
	)
)




#|
1 ]=> (search-for-primes 1000000)

1000003 *** 1
1000033 *** 1
1000037 *** 1
;Unspecified return value

1 ]=> (search-for-primes 10000000)

10000019 *** 3
10000079 *** 3
10000103 *** 3
;Unspecified return value

1 ]=> (search-for-primes 100000000)

100000007 *** 9
100000037 *** 9
100000039 *** 8
;Unspecified return value

1 ]=> (search-for-primes 1000000000)

1000000007 *** 27
1000000009 *** 28
1000000021 *** 26
;Unspecified return value

|#