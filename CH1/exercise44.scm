(define (smooth f)
	(lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx)))) 3.0)
)

(define (compose f g)
	(lambda (x) (f (g x)))  
)

(define (repeated f n)
	(if (= 1 n)
		f
		(compose f (repeated f (- n 1))) 
	)
)

(define (nth-smooth f n)
	((repeated smooth n) f)
)


#|



不能写成 (repeated (smooth f) n) 
因为我们需要得到的是(smooth (smooth (smooth f))) 这种形式
|#
