
#|

(while predicate
	body
)

(while (< i 100)  
     (display i)  
     (set! i (+ i 1)))



(define (while predicate body)
	(if predicate
		(begin body (while predicate body))
	)
)

(define while (lambda (predicate body) 
	                  (if predicate
	                  	 (begin body (while predicate body))))
)


|#

(while <predicate> <body>) 


(define (while->combination exp) 
	(define lambda-while (make-lambda (list predicate body) 
		                              (list (make-if predicate (make-begin (list body (list 'while predicate body)))) '())))
	(make-begin (list (list 'define 'while lambda-while) exp))
)

(define (while? exp) (tagged-list? exp 'while))
(define (while-predicate exp) (cadr exp)) 
(define (while-body exp) (cddr exp)) 

(define (make-lambda parameters body) 
	(cons 'lambda (cons parameters body)))

(define (make-if predicate consequent alternative)
     (list 'if predicate consequent alternative))

(define (make-begin seq) (cons 'begin seq))


