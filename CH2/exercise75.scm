(define (make-from-real-imag x y) 
	(define (dispatch op)
		(cond ((eq? op 'real-part) x) 
			  ((eq? op 'imag-part) y)
			  ((eq? op 'magnitude) (sqrt (+ (square x) (square y)))) 
			  ((eq? op 'angle) (atan y x))
			  (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
	dispatch)


(define (apply-generic op arg) (arg op))

(define (real-part z) (apply-generic 'real-part (make-from-real-imag 1 2))) 

;消息传递的编程方法
(define (cons x y) (define (dispatch m)
	(cond ((= m 0) x) 
		((= m 1) y)
		(else (error "Argument not 0 or 1: CONS" m)))) dispatch)
(define (car z) (z 0)) 
(define (cdr z) (z 1))


(define (make-from-mag-ang r a) 
	(define (dispatch op)
		(cond ((eq? op 'magnitude) r) 
			  ((eq? op 'angle) a)
			  ((eq? op 'real-part) (* r (cos a))) 
			  ((eq? op 'imag-part) (* r (sin a)))
			  (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
	dispatch)








