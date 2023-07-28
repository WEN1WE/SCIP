#|
(cond ((assoc 'b '((a 1) (b 2))) => cadr) 
	  (else false))

((cond? exp) (eval (cond->if exp) env))
|#



(define (cond-=>-clause? clause)
	(eq? (cadr clause) '=>)
)

(define (cond? exp) (tagged-list? exp 'cond)) 
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
	(eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
	(if (null? clauses)
		'false ; no else clause
		(let ((first (car clauses)) 
				(rest (cdr clauses)))
			(if (cond-else-clause? first) 
				(if (null? rest)
                	(sequence->exp (cond-actions first))
                	(error "ELSE clause isn't last: COND->IF"
                       clauses))
				(if (cond-=>-clause? first)
					(let ((recipient (caddr first))
						  (test (car first))
						 )
						(make-if test (list recipient test) (expand-clauses rest))

					)
					(make-if (cond-predicate first)
                     	(sequence->exp (cond-actions first))
                     	(expand-clauses rest))))))
				)
