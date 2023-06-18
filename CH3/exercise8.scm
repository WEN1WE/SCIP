(define f
	(let ((x 0))
		(lambda (n) x (set! x (+ n x)))
	)
)



;(+ (f 0) (f 1))

(define test
	(let ((x 10))
		(lambda (n) (set! x (+ x n)) x)
	)
)