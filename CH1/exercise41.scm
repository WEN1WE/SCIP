(define (double f)
	(lambda (x)
		(f (f x))
	) 
)

(define (inc x)
	(+ x 1)
)

#| 

1 ]=> (((double (double double)) inc) 5)

;Value: 21


((double double) f) = (forth f) f执行4次
((double (double double)) f) f执行4次这个程序执行4次，就是16次

|#


(((double double) inc) 5)   