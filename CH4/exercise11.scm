(define (true? x) (not (eq? x false))) 
(define (false? x) (eq? x false))


(define (make-procedure parameters body env) 
	(list 'procedure parameters body env))


(define (compound-procedure? p) 
	(tagged-list? p 'procedure))


(define (procedure-parameters p) (cadr p)) 
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))


(lookup-variable-value ⟨var⟩ ⟨env⟩)
(extend-environment ⟨variables⟩ ⟨values⟩ ⟨base-env⟩)
(define-variable! ⟨var⟩ ⟨value⟩ ⟨env⟩)
(set-variable-value! ⟨var⟩ ⟨value⟩ ⟨env⟩)



(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())


(define (make-frame variables values) 
	(cons variables values))

(define (frame-variables frame) (car frame))


(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env) 
	(if (= (length vars) (length vals))
		(cons (make-frame vars vals) base-env) 
		(if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))


(define (lookup-variable-value var env) 
	(define (env-loop env)
		(define (scan vars vals) 
			(cond ((null? vars)
						(env-loop (enclosing-environment env))) 
				  ((eq? var (car vars)) (car vals))
				  (else (scan (cdr vars) (cdr vals)))))
		(if (eq? env the-empty-environment) 
			(error "Unbound variable" var) 
			(let ((frame (first-frame env)))
      			(scan (frame-variables frame)
            		(frame-values frame)))))
  	(env-loop env))


(define (set-variable-value! var val env) 
	(define (env-loop env)
		(define (scan vars vals) 
			(cond ((null? vars)
						(env-loop (enclosing-environment env))) 
				  ((eq? var (car vars)) (set-car! vals val)) 
				  (else (scan (cdr vars) (cdr vals)))))
		(if (eq? env the-empty-environment) 
			(error "Unbound variable: SET!" var) 
			(let ((frame (first-frame env)))
		          (scan (frame-variables frame)
		                (frame-values frame)))))
  (env-loop env))


(define (define-variable! var val env) 
	(let ((frame (first-frame env)))
		(define (scan vars vals) 
			(cond ((null? vars)
				(add-binding-to-frame! var val frame)) 
				((eq? var (car vars)) (set-car! vals val)) 
				(else (scan (cdr vars) (cdr vals)))))
    	(scan (frame-variables frame) (frame-values frame))))






; new 


(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())


(define (make-frame variables values) 
	(map cons variables values))


(define (first-binding frame) (car frame))


(define (rest-binding frame) (cdr frame))

(define (binding-var binding)
	(car binding)
)

(define (binding-val binding)
	(cdr binding)
)

(define (add-binding-to-frame! var val frame)
	(set! frame (cons (cons var val) frame)))

(define (extend-environment vars vals base-env) 
	(if (= (length vars) (length vals))
		(cons (make-frame vars vals) base-env) 
		(if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env) 
	(define (env-loop env)
		(define (scan bindings)
			(let ((binding (first-binding bindings)))
				(cond ((null? binding)
					  		(env-loop (enclosing-environment env)))
				      ((eq? var (binding-var binding)) (binding-val binding))
				      (else (scan (rest-binding bindings)))

				)
			)
		)
			
		(if (eq? env the-empty-environment) 
			(error "Unbound variable" var) 
			(scan (first-frame env))))
  	(env-loop env))


(define (set-variable-value! var val env)  
	(define (env-loop env)
		(define (scan frame)
			(let ((binding (first-binding frame)))
				(cond ((null? binding)
					  		(env-loop (enclosing-environment env)))
				      ((eq? var (binding-var binding)) (set-cdr! binding (binding-val binding)))
				      (else (scan (rest-binding frame)))

				)
			)
		)
			
		(if (eq? env the-empty-environment) 
			(error "Unbound variable" var) 
			(scan (first-frame env))))
  	(env-loop env))


(define (define-variable! var val env) 
	(let ((first (first-frame env)))
		(define (scan bindings)
			(let ((binding (first-binding bindings)))
				(cond ((null? first-binding)
					  		(add-binding-to-frame! var val first)) 
				      ((eq? var (binding-var binding)) (set-cdr! binding (binding-val binding)))
				      (else (scan (rest-binding bindings)))

				)
			)
		)
		(scan first)
	)
)
			






