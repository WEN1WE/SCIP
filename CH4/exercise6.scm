
#|

(let ((⟨var1⟩ ⟨exp1⟩) . . . (⟨varn⟩ ⟨expn⟩)) ⟨body⟩)


((lambda (⟨var1⟩ ... ⟨varn⟩) ⟨body⟩)
⟨exp1⟩ ... ⟨expn⟩)

|#

(define (eval exp env)
	(cond ((self-evaluating? exp) exp)
	        ((variable? exp) (lookup-variable-value exp env))
	        ((quoted? exp) (text-of-quotation exp))
	        ((assignment? exp) (eval-assignment exp env))
	        ((definition? exp) (eval-definition exp env))
	        ((if? exp) (eval-if exp env))
	        ((lambda? exp) (make-procedure (lambda-parameters exp)
	                                       (lambda-body exp)
	                                       env))

	        ((begin? exp)
         		(eval-sequence (begin-actions exp) env))
        	((cond? exp) (eval (cond->if exp) env))


        	((let? exp) (apply (eval (let->combination exp) env) 
        		               (list-of-values (list-of-exps (let-clauses exp)))))


        	((application? exp)
         		(apply (eval (operator exp) env)
                	(list-of-values (operands exp) env)))
			(else
				(error "Unknown expression type: EVAL" exp))))



(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
	(list 'lambda (list-of-parameters (let-clauses exp)) (let-body exp))
)

(define (let-clauses exp)
	(cadr exp)
)

(define (list-of-parameters clauses)
	(define (helper lambda-clauses)
		(if (null? lambda-clauses)
			'()
			(let ((clause (car lambda-clauses)))
				(cons (car clause) (helper (cdr lambda-clauses)))
			)

		)

	)
	(helper clauses)
)

(define (list-of-exps clauses)
	(define (helper lambda-clauses)
		(if (null? lambda-clauses)
			'()
			(let ((clause (car lambda-clauses)))
				(cons (cadr clause) (helper (cdr )))
			)

		)
	)
	(helper clauses)
)


(define (let-body exp)
	(caddr exp)
)


(define (list-of-values exps env) 
	(if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


