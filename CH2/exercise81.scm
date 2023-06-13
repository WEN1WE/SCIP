(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags))) 
			(if proc
				(apply proc (map contents args)) 
				(if (and (= (length args) 2) (not (= (car type-tags) (cadr type-tags))))
					(let ((type1 (car type-tags)) 
						  (type2 (cadr type-tags)) 
						  (a1 (car args))
                          (a2 (cadr args)))
                    (let ((t1->t2 (get-coercion type1 type2)) 
                    	 (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else (error "No method for these types" 
                            	         (list op type-tags))))))


	                (error "No method for these types"
	                       (list op type-tags))
	            )
			)
		)
	)
)



(define (install-complex-package)
	;; imported procedures from rectangular and polar packages 
	(define (make-from-real-imag x y)
		((get 'make-from-real-imag 'rectangular) x y)) 
	(define (make-from-mag-ang r a)
		((get 'make-from-mag-ang 'polar) r a))

	;; internal procedures
	(define (add-complex z1 z2)
    	(make-from-real-imag (+ (real-part z1) (real-part z2))
                         	 (+ (imag-part z1) (imag-part z2))))
	(define (sub-complex z1 z2)
		(make-from-real-imag (- (real-part z1) (real-part z2))
							 (- (imag-part z1) (imag-part z2)))) 
	(define (mul-complex z1 z2)
    	(make-from-mag-ang (* (magnitude z1) (magnitude z2))
                           (+ (angle z1) (angle z2))))
	(define (div-complex z1 z2)
		(make-from-mag-ang (/ (magnitude z1) (magnitude z2))
						   (- (angle z1) (angle z2))))

	(define (complex->complex z) z) 


	(define (scheme-number->complex n) 
		(make-complex-from-real-imag (contents n) 0))

	;; interface to rest of the system
	(define (tag z) (attach-tag 'complex z))

	(put 'add '(complex complex)
		(lambda (z1 z2) (tag (add-complex z1 z2))))
	(put 'sub '(complex complex)
		(lambda (z1 z2) (tag (sub-complex z1 z2))))
	(put 'mul '(complex complex)
		(lambda (z1 z2) (tag (mul-complex z1 z2))))
	(put 'div '(complex complex)
		(lambda (z1 z2) (tag (div-complex z1 z2))))
	(put 'make-from-real-imag 'complex
		(lambda (x y) (tag (make-from-real-imag x y))))
	(put 'make-from-mag-ang 'complex
		(lambda (r a) (tag (make-from-mag-ang r a))))
	

	(put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)


	(put-coercion 'scheme-number
	              'complex
	              scheme-number->complex)

	(put-coercion 'complex 'complex complex->complex)
    'done)



(define (install-scheme-number-package)
	(define (tag x) (attach-tag 'scheme-number x)) 
	(define (scheme-number->scheme-number n) n) 
	(put 'add '(scheme-number scheme-number)
		(lambda (x y) (tag (+ x y))))
	(put 'sub '(scheme-number scheme-number)
		(lambda (x y) (tag (- x y))))
	(put 'mul '(scheme-number scheme-number)
		(lambda (x y) (tag (* x y))))
	(put 'div '(scheme-number scheme-number)
		(lambda (x y) (tag (/ x y))))
	(put 'make 'scheme-number (lambda (x) (tag x)))

	(put 'exp '(scheme-number scheme-number) 
		(lambda (x y) (tag (expt x y))))
        ; using primitive expt

	(put-coercion 'scheme-number
	              'scheme-number
	              scheme-number->scheme-number)

	'done)










(define (exp x y) (apply-generic 'exp x y))  ;x y complex
;程序会无限循环














