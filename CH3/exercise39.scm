(define x 10)

(define s (make-serializer)) 

(parallel-execute (lambda () (set! x ((s (lambda () (* x x)))))) 
	              (s (lambda () (set! x (+ x 1)))))


;下面2程序不能同时执行
(lambda () (* x x)) 
(lambda () (set! x (+ x 1)))


101 可以
121 可以
110 不行
11 不行
100 可以


         