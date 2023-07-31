
; 删除第一个遇见的约束
(define (make-unbound! var env)
	(define (env-loop env)
		(define (scan vars vals last-vars last-vals) 
			(cond ((null? vars)
						(env-loop (enclosing-environment env))) 
				  ((eq? var (car vars)) 
				  	   (if last-vals
				  	   		(begin (set-cdr! last-vars (cdr vars)) 
				  	   			   (set-cdr! last-vals (cdr vals)))
				  	   		(set-car! env (make-frame (cdr vars) (cdr vals)))
				  	   )
				  ) 
				  (else (scan (cdr vars) (cdr vals) vars vals))))
		
		(if (eq? env the-empty-environment) 
			(error "Unbound variable: SET!" var) 
			(let ((frame (first-frame env)))
		          (scan (frame-variables frame)
		                (frame-values frame)
		                false
		                false
		           )
		    )
		)
	)
  (env-loop env)
)