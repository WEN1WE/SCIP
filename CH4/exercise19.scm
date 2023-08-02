(let ((a 1)) 
	(define (f x)
		(define b (+ a x)) 
		(define a 5)
		(+ a b))
	(f 10))

如果设计出完全统一的定义，那么需要分析依赖关系


#|

1 ]=> (load "exercise19.scm")

;Loading "exercise19.scm"... done
;Value: 16


|#