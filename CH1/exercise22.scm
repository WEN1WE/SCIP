(define (smallest-divisor n)
	(find-divisor n 2)
)

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (+ test-divisor 1)))
	) 
)

(define (divides? a b)
	(= (remainder b a) 0) 
)

(define (prime? n)
	(= n (smallest-divisor n)))


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

#|
由于程序运行太快了，无法看见时间
这个程序可以看出 cond 条件后面的语句 可以写多个
cond 里面可以包含cond
当程序无返回值时，编译器会显示 ;Unspecified return value


|#

(define (search-for-primes-helper n left) 
	(cond ((> left 0) 
				(cond ((prime? n) (timed-prime-test n) (search-for-primes-helper (+ n 2) (- left 1))) 
                      (else (search-for-primes-helper (+ n 2) left))

				)
		  )		            
	)
)



