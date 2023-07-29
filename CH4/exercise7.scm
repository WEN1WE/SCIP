
#|

(let* ((x 3) (y (+ x 2)) (z ( + x y 5))) (* x z))

(let ((x 3))
	(let ((y (+ x 3)))
		(let ((z (+ x y 5)))
			(* x z)
		)
	)
)
|#

; body is a list

(define (let*? exp) (tagged-list? exp 'let*))

(define (let*->nested-lets exp)

	(define body (let*-body exp))

	(define (helper bindings)
		(if (last-exp? bindings)
			(make-let bindings body)
			(make-let (list (first-exp bindings)) 
				      (list (let*->nested-lets (rest-exps bindings))))
		)
	)

	(define (make-let bindings body)
		(cons 'let (cons bindings body))
	)

	(helper (let*-bindings exp))
)

(define (let*-bindings exp)
	(cadr exp)
)

(define (let*-body exp)
	(cddr exp)
)


(define (make-lambda parameters body) 
	(cons 'lambda (cons parameters body)))


(define (last-exp? seq) (null? (cdr seq))) 
(define (first-exp seq) (car seq)) 
(define (rest-exps seq) (cdr seq))













