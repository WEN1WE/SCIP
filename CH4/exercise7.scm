
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


(define (let*? exp) (tagged-list? exp 'let*))

(define (let*->nested-lets exp)

	(define body (let*-body exp))

	(define (helper bindings)
		(if (last-exp? bindings)
			(list 'let (list (first-exp bindings)) body)
			(list 'let (list (first-exp bindings)) (let*->nested-lets (rest-exps bindings)))
		)
	)

	(helper (let*-bindings exp))
)

(define (let*-bindings exp)
	(cadr exp)
)

(define (let*-body exp)
	(caddr exp)
)

(define (last-exp? seq) (null? (cdr seq))) 
(define (first-exp seq) (car seq)) 
(define (rest-exps seq) (cdr seq))













