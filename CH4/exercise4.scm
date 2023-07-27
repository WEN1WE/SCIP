
;(and expr1 expr2 ... exprn)
;(or expr1 expr2 ... exprn)


(define (eval exp env) 
	(cond ((and? exp) (eval-and (and-actions exp) env))
		  ((or? exp) (eval-or (or-actions exp) env))
	)
)

(define (eval-and exps env)
	(cond ((null? exps) true)

		  ((last-exp? exps) (eval (first-exp exps) env))
		  (else 
		  		(let ((first (eval (first-exp exps) env)))
			  		(if (false? first)
			  			first
			  			(eval-and (rest-exps exps) env)
			  		)
		  		)
		  )
	)
)

(define (eval-or exps env)
	(cond ((null? exps) false)
		  ((last-exp? exps) (eval (first-exp exps) env))
		  (else 
		  		(let ((first (eval (first-exp exps) env)))
		  			(if (true? first)
		  				first 
		  				(eval-or (rest-exps exps) env)
		  			)
		  		)
		  )
	)
)

(define (tagged-list? exp tag) 
	(if (pair? exp)
            (eq? (car exp) tag)
            false))

(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))

(define (and-actions exp) (cdr exp))
(define (or-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq))) 
(define (first-exp seq) (car seq)) 
(define (rest-exps seq) (cdr seq))


; derived expressions

#|
	(and expr1 expr2 ... exprn)
	
	(if expr1
		(if expr2
			...
			(if exprn
				true
				false
			)

		)
		false
	)

|#



(define (eval exp env) 
	(cond ((and? exp) (eval (and->if exp) env))
		  ((or? exp) (eval (or->if exp) env))
	)
)

(define (and-clauses exp) (cdr exp))
(define (or-clauses exp) (cdr exp))


(define (make-if predicate consequent alternative)
     (list 'if predicate consequent alternative))



(define (and->if exp) (expand-and-clauses (and-clauses exp)))
(define (or->if exp) (expend-or-clauses (and-clauses exp)))




(define (expand-and-clauses clauses)
	(if (null? clauses)
		'true

		(let ((first (car clauses)) 
				(rest (cdr clauses)))

			(make-if first (expand-and-clauses rest) 'false)
		)
	)
)

(define (expand-or-clauses clauses)
	(if (null? clauses)
		'false

		(let ((first (car clauses)) 
				(rest (cdr clauses)))

			(make-if first 'true (expand-or-clauses rest))
		)
	)
)















