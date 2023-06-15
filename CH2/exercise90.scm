(define (install-sparse-term-list)   
     ;inner 
     (define (make-sparse variable term-list) (cons variable term-list)) 
     (define (adjoin-term term term-list) 
         (if (=zero? (coeff term)) 
             term-list  
             (cons (term term-list))))  
  
     (define (first-term term-list) (car term-list)) 
     (define (rest-terms term-list) (cdr term-list)) 
  
     ;interface 
     (define (tag term-list) (attach-tag 'sparse term-list)) 
  
     (put 'adjoin-term 'sparse  adjoin-term)  
  
     (put 'first-term '(sparse)  
         (lambda (term-list) (first-term term-list))) 
  
     (put 'rest-term '(sparse)  
         (lambda (term-list) (tag (rest-terms term-list)))) 
     (put 'make 'sparse
		 (lambda (var terms) (tag (make-sparse var terms))
     'done) 



(define (install-dense-term-list)     
     ;inner 
     (define (make-dense variable term-list) (cons variable term-list)) 
     (define (adjoin-term term term-list)  
     (cond ((=zero? (coeff term)) term-list)  
             ((=equ? (order term) (length term-list)) (cons (coeff term) term-list))  
             (else (adjoin-term term (cons 0 term-list)))))  
  
     (define (first-term term-list) (make-term (- (length term-list) 1) (car term-list))) 
     (define (rest-terms term-list) (cdr term-list)) 
  
     ;interface 
     (define (tag term-list) (attach-tag 'dense term-list)) 
  
     (put 'adjoin-term 'dense adjoin-term)  
  
     (put 'first-term '(dense)  
         (lambda (term-list) (first-term term-list))) 
  
     (put 'rest-term '(dense)  
         (lambda (term-list) (tag (rest-terms term-list)))) 
     'done) 
	 (put 'make 'dense
		(lambda (var terms) (tag (make-dense var terms)))) 


 (define (adjoin-term term term-list)  
     ((get 'adjoin-term (type-tag term-list)) term term-list)) 
  
 (define (first-term term-list) (apply-generic 'first-term term-list)) 
 (define (rest-term term-list) (apply-generic 'rest-term term-list)) 


 (define (install-polynomial-package)
	;; internal procedures
;	; representation of poly
	(define (make-from-dense variable term-list) 
		((get 'make 'dense) variable term-list)
	) 
	(define (make-from-sparse variable term-list) 
		((get 'make 'sparse) variable term-list)
	) 


	(define (variable p) (car p))
	(define (term-list p) (cdr p))
	(define (variable? x) (symbol? x))

	(define (same-variable? v1 v2)
		(and (variable? v1) (variable? v2) (eq? v1 v2)))
	;; representation of terms and term lists


	(define (adjoin-term term term-list) 
		(if (=zero? (coeff term))
			term-list
			(cons term term-list)))




	(define (add-poly p1 p2) . . .)
	⟨procedures used by add-poly⟩
	(define (mul-poly p1 p2) . . .)
	⟨procedures used by mul-poly⟩

	(define (zero-poly? p)
		(define (zero-terms? terms)
			(or (empty-termlist? terms)
                (and (=zero? (coeff (first-term terms))))
                     (zero-terms (rest-terms terms))
			)
		)
		(zero-terms? (term-list p))
	)

	;; interface to rest of the system
	(define (tag p) (attach-tag 'polynomial p))
	(put 'add '(polynomial polynomial)
		(lambda (p1 p2) (tag (add-poly p1 p2)))) 
	(put 'mul '(polynomial polynomial)
		(lambda (p1 p2) (tag (mul-poly p1 p2)))) 
	(put 'make 'polynomial
		(lambda (var terms) (tag (make-poly var terms)))) 

	(put '=zero? '(polynomial) zero-poly?)
	(put 'sub? '(polynomial polynomial) 
		(lambda (p1 p2) (tag (sub-terms p1 p2))))

	(put 'make-from-dense 'polynomial
		(lambda (var terms) (tag (make-from-dense var terms)))) 

	(put 'make-from-sparse 'polynomial
		(lambda (var terms) (tag (make-from-sparse var terms)))

	)


	'done)

(define (the-empty-termlist) '())
(define (empty-termlist? term-list) (null? term-list)) 
(define (make-term order coeff) (list order coeff))
(define (order term) (car term)) 
(define (coeff term) (cadr term))

 (define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags))) 
			(if proc
            	(apply proc (map contents args))
          		(error
          			"No method for these types: APPLY-GENERIC"
            	(list op type-tags))))))


