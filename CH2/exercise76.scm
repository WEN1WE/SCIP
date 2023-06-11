

explicit dispatch

(define (real-part z) 
	(cond ((rectangular? z)
          		(real-part-rectangular (contents z)))
          ((polar? z)
				(real-part-polar (contents z)))
		  (else (error "Unknown type: REAL-PART" z))))
; 这种方式增加operations方便，不影响其他方法




data-directed style

(define (install-rectangular-package)
	;; internal procedures
	(define (real-part z) (car z))
	(define (imag-part z) (cdr z))
	(define (make-from-real-imag x y) (cons x y)) 
	(define (magnitude z)
    	(sqrt (+ (square (real-part z))
                 (square (imag-part z)))))
	(define (angle z)
		(atan (imag-part z) (real-part z)))
	(define (make-from-mag-ang r a)
		(cons (* r (cos a)) (* r (sin a))))


	;; interface to the rest of the system
	(define (tag x) (attach-tag 'rectangular x)) 
	(put 'real-part '(rectangular) real-part) 
	(put 'imag-part '(rectangular) imag-part) 
	(put 'magnitude '(rectangular) magnitude) 
	(put 'angle '(rectangular) angle)
	(put 'make-from-real-imag 'rectangular
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'rectangular
		(lambda (r a) (tag (make-from-mag-ang r a))))
	'done)
;这种方法增加一个types方便


message-passing-style

(define (make-from-real-imag x y) 
	(define (dispatch op)
		(cond ((eq? op 'real-part) x) 
			  ((eq? op 'imag-part) y)
			  ((eq? op 'magnitude) (sqrt (+ (square x) (square y)))) 
			  ((eq? op 'angle) (atan y x))
			  (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
	dispatch)
;这种方法增加一个types方便








