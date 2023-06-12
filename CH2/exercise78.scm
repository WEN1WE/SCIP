



;测试
(add 1 2)
(apply-generic 'add 1 2)
	type-tags = (map type-tag (1 2)) 
	          = ('scheme-number 'scheme-number)
	proc = (get 'add ('scheme-number 'scheme-number))
	     = (lambda (x y) (tag (+ x y)))
	(map contents (1 2)) = (1 2)
	(apply proc (1 2)) = (proc 1 2) = (tag (+ 1 2)) = (attach-tag 'scheme-number x) = 3


(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y)) 
(define (mul x y) (apply-generic 'mul x y)) 
(define (div x y) (apply-generic 'div x y))


(define (attach-tag type-tag contents) 
	(if (number? contents)
		contents
		(cons type-tag contents))
	)
	

(define (type-tag datum) 
	(cond ((pair? datum) (car datum))
		  ((number? datum) 'scheme-number)
		  (else (error "Bad tagged datum: TYPE-TAG" datum))
	)
) 

(define (contents datum)
	(cond ((pair? datum) (cdr datum))
		  ((number? datum) datum)
		  (else (error "Bad tagged datum: CONTENTS" datum))
   )
)

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags))) 
			(if proc
            	(apply proc (map contents args))
          		(error
          			"No method for these types: APPLY-GENERIC"
            	(list op type-tags))))))

(define (attach-tag type-tag contents) 
	(cons type-tag contents))

(define (install-scheme-number-package)
	(define (tag x) (attach-tag 'scheme-number x)) 
	(put 'add '(scheme-number scheme-number)
		(lambda (x y) (tag (+ x y))))
	(put 'sub '(scheme-number scheme-number)
		(lambda (x y) (tag (- x y))))
	(put 'mul '(scheme-number scheme-number)
		(lambda (x y) (tag (* x y))))
	(put 'div '(scheme-number scheme-number)
		(lambda (x y) (tag (/ x y))))
	(put 'make 'scheme-number (lambda (x) (tag x)))

	'done)

(define (make-scheme-number n) 
	((get 'make 'scheme-number) n))










