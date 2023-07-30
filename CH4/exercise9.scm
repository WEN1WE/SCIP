
#|
(while <predicate> <body>) 

(while (< i 100)  
     (display i)  
     (set! i (+ i 1)))

(while predicate body)

(define (while predicate body)
	(define while-iter (lambda (predicate-iter body-iter) 
		                  (if predicate-iter
		                  	 (begin body (while-iter predicate-iter body-iter))))
	)
	(while-iter predicate body)
)
|#




(define (while->combination exp) 
	(define lambda-while (make-lambda (list predicate body) 
		                              (list (make-if predicate (make-begin (list body (list 'while-iter predicate body)))) '())))
	(make-begin (list (list 'define 'while-iter lambda-while) (list 'while-iter (while-predicate exp) (while-body exp))))
)

(define (while? exp) (tagged-list? exp 'while))
(define (while-predicate exp) (cadr exp)) 
(define (while-body exp) (cddr exp)) 

(define (make-lambda parameters body) 
	(cons 'lambda (cons parameters body)))

(define (make-if predicate consequent alternative)
     (list 'if predicate consequent alternative))

(define (make-begin seq) (cons 'begin seq))


