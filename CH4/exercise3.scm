(put 'eval 'quoted (lambda (exp env) (text-of-quotation exp)))
(put 'eval 'set! (lambda (exp env) (eval-assignment exp env)))
(put 'eval 'define (lambda (exp env) (eval-definition exp env)))
(put 'eval 'if (lambda (exp env) (eval-if exp env)))
(put 'eval 'lambda (lambda (exp env) (make-procedure (lambda-parameters exp)
	                                                 (lambda-body exp)
	                                                 (env))))

(put 'eval 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env)))
(put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env)))


(define (eval-data-directed exp env)
	(let ((proc (get 'eval (car exp))))
		(if proc
			(proc exp env)

		)
	)
)

