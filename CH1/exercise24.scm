(define (expmod base exp m) 
	(cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else (remainder (* base (expmod base (- exp 1) m)) m)))
)



(define (fermat-test n) 
	(define (try-it a)
    	(= (expmod a n n) a)
    )
	(try-it (+ 1 (random (- n 1))))
)


(define (fast-prime? n times) 
	(cond ((= times 0) true)
		  ((fermat-test n) (fast-prime? n (- times 1))) 
		  (else false))
)


(define (prime? n)
	(fast-prime? n 10) 
)


(define (runtime) (real-time-clock))

(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (runtime)))

(define (start-prime-test n start-time) 
	(if (prime? n)
		(report-prime (- (runtime) start-time)) 0)) 

(define (report-prime elapsed-time)
	(display " *** ")
    (display elapsed-time))


#|
根据输出，可以看出，当输入增加到n^2时，时间只增加了一倍，这样程序效率大大增加了

1 ]=> (timed-prime-test 1000003) 

1000003 *** 2
;Unspecified return value

1 ]=> (timed-prime-test 1000000000039)

1000000000039 *** 4
;Unspecified return value

|#

