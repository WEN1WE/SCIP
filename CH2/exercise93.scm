(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))




(define (gcd-terms a b) (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (remainder-terms a b)
	(cadr (div-terms a b))
)

(define (install-rational-package) 
	;; internal procedures
	(define (numer x) (car x)) 
	(define (denom x) (cdr x)) 

	(define (make-rat n d) (cons n d))
	(define (add-rat x y)
		(make-rat (add (mul (numer x) (denom y))
                     (mul (numer y) (denom x)))
              	  (mul (denom x) (denom y))))
	(define (sub-rat x y)
		(make-rat (div (mul (numer x) (denom y))
                     (mul (numer y) (denom x)))
                  (mul (denom x) (denom y))))
	(define (mul-rat x y)
		(make-rat (mul (numer x) (numer y))
				  (mul (denom x) (denom y)))) 
	(define (div-rat x y)
    	(make-rat (mul (numer x) (denom y))
                  (mul (denom x) (numer y))))

	(define (equ-rat? x y)
		(and (= (numer x) (numer y)) (= (denom x) (denom y)))
	)

	;; interface to rest of the system
	(define (tag x) (attach-tag 'rational x)) 
	(put 'add '(rational rational)
		(lambda (x y) (tag (add-rat x y)))) 
	(put 'sub '(rational rational)
		(lambda (x y) (tag (sub-rat x y)))) 
	(put 'mul '(rational rational)
		(lambda (x y) (tag (mul-rat x y)))) 
	(put 'div '(rational rational)
		(lambda (x y) (tag (div-rat x y))))
	(put 'make 'rational
		(lambda (n d) (tag (make-rat n d))))
	
	(put 'equ? '(rational rational) equ-rat?)
	(put '=zero? '(rational) (lambda (x) (= (numer x) 0)))
	'done)


(define (make-rational n d)
  ((get 'make 'rational) n d))



(define (div-terms L1 L2) 
	(if (empty-termlist? L1)
		(list (the-empty-termlist) (the-empty-termlist)) 

		(let ((t1 (first-term L1))
			 (t2 (first-term L2)))

			(if (> (order t2) (order t1))
				(list (the-empty-termlist) L1)

				(let ((new-c (div (coeff t1) (coeff t2)))
  					 (new-o (- (order t1) (order t2)))) 
				  (let ((rest-of-result
						(sub L1 (mul (adjoin-term (make-term new-o new-c) (the-empty-termlist)) L2)))) 

				      (let ((next (div-terms rest-of-result L2)))
				      	 (list (adjoin-term (make-term new-o new-c) (car next)) (cadr next))

				      )

				  )
				)
			)
		)
	)

)   















