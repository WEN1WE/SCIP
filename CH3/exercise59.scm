(define (integrate-series series)
	(define (helper s i)
		(cons-stream (/ (stream-car s) i) (helper (stream-cdr s) (+ i 1)))
	)
	(helper series 1)
)

(define exp-series
	(cons-stream 1 (integrate-series exp-series)))

(define (negative series)
	(cons-stream (* -1 (stream-car series)) (negative (stream-cdr series)))
)

(define cosine-series (cons-stream 1 (negative (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (show s)
	(define (helper i)
		(if (< i 10)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)



#|
1 ]=> (show sine-series)

0
1
0
-1/6
0
1/120
0
-1/5040
0
1/362880
;Unspecified return value


1 ]=> (show cosine-series)

1
0
-1/2
0
1/24
0
-1/720
0
1/40320
0
;Unspecified return value

|#












