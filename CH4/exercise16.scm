(lambda ⟨vars⟩ 
	(define u ⟨e1⟩) 
	(define v ⟨e2⟩) 
	⟨e3⟩)

(lambda ⟨vars⟩
	(let ((u '*unassigned*)
		 (v '*unassigned*)) 
	(set! u ⟨e1⟩)
	(set! v ⟨e2⟩) 
	⟨e3⟩))


(define (lookup-variable-value var env) 
	(define (env-loop env)
		(define (scan vars vals) 
			(cond ((null? vars)
						(env-loop (enclosing-environment env))) 
				  ((eq? var (car vars)) 
				  		(let ((temp (car vals)))
				  			(if (eq? temp '*unassigned*)
				  				(error "unassigned" var)
				  				temp
				  			)
				  		)
				  )
				  (else (scan (cdr vars) (cdr vals)))))
		(if (eq? env the-empty-environment) 
			(error "Unbound variable" var) 
			(let ((frame (first-frame env)))
      			(scan (frame-variables frame)
            		(frame-values frame)))))
  	(env-loop env))