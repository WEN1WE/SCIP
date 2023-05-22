#|
0.61803398875  需要从新引入一个标记，才能表现这个递归过程
|#

(define (cont-frac n d k)
	(define (cont-frac-help i)
		(if (= i k)
			(/ (n i) (d i))
			(/ (n i) (+ (d i) (cont-frac-help (+ i 1)))) 
		)
	)
	(cont-frac-help 1)
)


;;;(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)
#|
;Loading "exercise37.scm"... done
;Value: .6180555555555556
|#

(define (cont-frac-iter n d k)  
	(define (iter i result)
		(if (= i 0)
			result
			(iter (- i 1) (/ (n i) (+ result (d i))))
		) 
	)
	(iter k 0)
)

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11)


#|
;Loading "exercise37.scm"... done
;Value: .6180555555555556

|#