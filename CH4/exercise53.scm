(define apply-in-underlying-scheme apply)


(define (eval exp env) ((analyze exp) env))
(define (ambeval exp env succeed fail) 
	((analyze exp) env succeed fail))

(define (analyze exp)
	(cond ((self-evaluating? exp) (analyze-self-evaluating exp)) 
		((quoted? exp) (analyze-quoted exp))
		((variable? exp) (analyze-variable exp)) 
		((assignment? exp) (analyze-assignment exp)) 
		((pre-assignment? exp) (analyze-pre-assignment exp))
		((definition? exp) (analyze-definition exp))
		((if-fail? exp) (analyze-if-fail exp))
		((if? exp) (analyze-if exp))

		((let? exp) (analyze (let->combination exp)))
		((amb? exp) (analyze-amb exp))
		((lambda? exp) (analyze-lambda exp))
		((begin? exp) (analyze-sequence (begin-actions exp))) 

		((cond? exp) (analyze (cond->if exp)))
		((application? exp) (analyze-application exp))
		(else (error "Unknown expression type: ANALYZE" exp))))



(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  
  (cons (make-lambda (let-vars exp) 
                     (let-body exp)) 
        (let-exps exp))) 



(define (if-fail? exp)
	(tagged-list? exp 'if-fail))


(define (analyze-if-fail exp)
	(let ((a (analyze (cadr exp)))
		  (b (analyze (caddr exp))))

		(lambda (env succeed fail)
			(a env 
				succeed 
				(lambda () (b env succeed fail))
			)
		)
	)
)





(define (pre-assignment? exp)
	(tagged-list? exp 'permanent-set!)
)

(define (analyze-assignment exp)
	(let ((var (assignment-variable exp))
		 (vproc (analyze (assignment-value exp)))) 
		(lambda (env succeed fail)
			(vproc env
				(lambda (val fail2) ; *1*
					(let ((old-value
							(lookup-variable-value var env)))

		                 (set-variable-value! var val env)
		                 (succeed 'ok
		                 			(lambda () ; *2* 
		                 				(set-variable-value!
		   								var old-value env)
		  								(fail2)))))
				fail))))

(define (analyze-pre-assignment exp)
	(let ((var (assignment-variable exp))
		(vproc (analyze (assignment-value exp))))

		(lambda (env succeed fail)
			(vproc env
				(lambda (val fail2)
					(set-variable-value! var val env)
					(succeed 'ok fail2)
				)

				fail)
		)
	)

)

#|

(define (analyze-self-evaluating exp) 
	(lambda (env) exp))

(define (analyze-quoted exp)
	(let ((qval (text-of-quotation exp)))
		(lambda (env) qval)))


(define (analyze-variable exp)
	(lambda (env) (lookup-variable-value exp env)))


(define (analyze-assignment exp)
	(let ((var (assignment-variable exp))
			(vproc (analyze (assignment-value exp)))) 
		(lambda (env)
      		(set-variable-value! var (vproc env) env)
			'ok)))

(define (analyze-definition exp)
	(let ((var (definition-variable exp))
		(vproc (analyze (definition-value exp))))
	(lambda (env)
		(define-variable! var (vproc env) env) 
		'ok)))

(define (analyze-if exp)
	(let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
		(aproc (analyze (if-alternative exp)))) 
	(lambda (env) (if (true? (pproc env))
                      (cproc env)
                      (aproc env)))))


(define (analyze-lambda exp)
	(let ((vars (lambda-parameters exp))
		  (bproc (analyze-sequence (lambda-body exp)))) 
		(lambda (env) (make-procedure vars bproc env))))

(define (analyze-sequence exps) 
	(define (sequentially proc1 proc2)
		(lambda (env) (proc1 env) (proc2 env))) 
	(define (loop first-proc rest-procs)
		(if (null? rest-procs) 
			first-proc
        	(loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
	(let ((procs (map analyze exps)))
		(if (null? procs) (error "Empty sequence: ANALYZE")) 
		(loop (car procs) (cdr procs))))


(define (analyze-application exp)
	(let ((fproc (analyze (operator exp)))
		 (aprocs (map analyze (operands exp)))) 
		(lambda (env)
			(execute-application
			(fproc env)
			(map (lambda (aproc) (aproc env))
				aprocs)))))

(define (execute-application proc args)
	(cond ((primitive-procedure? proc) 
		(apply-primitive-procedure proc args))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment
           (procedure-parameters proc)
           args
           (procedure-environment proc))))
		(else
			(error "Unknown procedure type: EXECUTE-APPLICATION"
				proc))))


|#

(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))


(define (analyze-self-evaluating exp) 
	(lambda (env succeed fail)
		(succeed exp fail)))

(define (analyze-quoted exp)
	(let ((qval (text-of-quotation exp))) 
		(lambda (env succeed fail)
			(succeed qval fail))))


(define (analyze-variable exp)
	(lambda (env succeed fail)
		(succeed (lookup-variable-value exp env) fail)))


(define (analyze-lambda exp)
	(let ((vars (lambda-parameters exp))
		 (bproc (analyze-sequence (lambda-body exp)))) 
	  (lambda (env succeed fail)
      	(succeed (make-procedure vars bproc env) fail))))

;; 上面这些分析都是百分百成功的


#|
exp : 1
(lambda (env succeed fail)
	(succeed 1 fail)))



|#


(define (analyze-if exp)
	(let ((pproc (analyze (if-predicate exp)))
         (cproc (analyze (if-consequent exp)))
         (aproc (analyze (if-alternative exp)))) 
	(lambda (env succeed fail)
		(pproc env
		;; success continuation for evaluating the predicate 
		;; to obtain pred-value
		(lambda (pred-value fail2)
			(if (true? pred-value)
				(cproc env succeed fail2) 
				(aproc env succeed fail2)))
		;; failure continuation for evaluating the predicate
		fail))))



(define (analyze-sequence exps) 
	(define (sequentially a b)
		(lambda (env succeed fail) 
			(a env
				;; success continuation for calling a 
				(lambda (a-value fail2)
					(b env succeed fail2))
					;; failure continuation for calling a 
					fail)))
	(define (loop first-proc rest-procs) 
		(if (null? rest-procs)
        	first-proc
        	(loop (sequentially first-proc
                            (car rest-procs))
              (cdr rest-procs))))
	(let ((procs (map analyze exps))) 
		(if (null? procs)
        	(error "Empty sequence: ANALYZE"))
    	(loop (car procs) (cdr procs))))


(define (analyze-definition exp)
	(let ((var (definition-variable exp))
		 (vproc (analyze (definition-value exp))))
		(lambda (env succeed fail) 
			(vproc env
				(lambda (val fail2) 
					(define-variable! var val env) 
					(succeed 'ok fail2))
				fail))))



(define (analyze-assignment exp)
	(let ((var (assignment-variable exp))
		 (vproc (analyze (assignment-value exp)))) 
		(lambda (env succeed fail)
			(vproc env
				(lambda (val fail2) ; *1*
					(let ((old-value
							(lookup-variable-value var env)))

		                 (set-variable-value! var val env)
		                 (succeed 'ok
		                 			(lambda () ; *2* 
		                 				(set-variable-value!
		   								var old-value env)
		  								(fail2)))))
				fail))))



(define (analyze-application exp)
	(let ((fproc (analyze (operator exp)))
		  (aprocs (map analyze (operands exp)))) 
		(lambda (env succeed fail)
			(fproc env
				(lambda (proc fail2)
               		(get-args aprocs
                         env
                         (lambda (args fail3) 
                         	(execute-application
   				             proc args succeed fail3))
			             fail2))
				fail))))



(define (get-args aprocs env succeed fail) 
	(if (null? aprocs)
      (succeed '() fail)
      ((car aprocs)
		env
		;; success continuation for this aproc 
		(lambda (arg fail2)
			(get-args
				(cdr aprocs)
				env
				;; success continuation for 
				;; recursive call to get-args 
				(lambda (args fail3)
            		(succeed (cons arg args) fail3))
          		fail2))
			fail)))



(define (execute-application proc args succeed fail) 
	(cond ((primitive-procedure? proc)
         (succeed (apply-primitive-procedure proc args)
                  fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment
           (procedure-parameters proc)
           args
           (procedure-environment proc))
			succeed
			fail)) 
        (else
         (error "Unknown procedure type: EXECUTE-APPLICATION"
                proc))))


(define (analyze-amb exp)
	(let ((cprocs (map analyze (amb-choices exp))))
		(lambda (env succeed fail) 
			(define (try-next choices)
				(if (null? choices) 
					(fail)
					((car choices)
             		  env
                      succeed
    				  (lambda () (try-next (cdr choices)))))) 
			(try-next cprocs))))














(define (list-of-values exps env) 
	(if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


(define (eval-if exp env)
	(if (true? (eval (if-predicate exp) env))
	      (eval (if-consequent exp) env)
	      (eval (if-alternative exp) env)))

(define (eval-sequence exps env) 
	(cond ((last-exp? exps)
         (eval (first-exp exps) env))
		 (else
			(eval (first-exp exps) env) 
			(eval-sequence (rest-exps exps) env))))


(define (eval-assignment exp env) 
	(set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
	'ok)



(define (eval-definition exp env) 
	(define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
	'ok)


(define (self-evaluating? exp) 
	(cond ((number? exp) true)
		  ((string? exp) true) 
		  (else false)))

(define (variable? exp) (symbol? exp))


(define (quoted? exp) (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))


(define (tagged-list? exp tag) 
	(if (pair? exp)
            (eq? (car exp) tag)
            false))

; assignment
(define (assignment? exp) (tagged-list? exp 'set!)) 
(define (assignment-variable exp) (cadr exp)) 
(define (assignment-value exp) (caddr exp))


; define 
(define (definition? exp) (tagged-list? exp 'define))


(define (definition-variable exp)
	(if (symbol? (cadr exp)) 
		(cadr exp)
		(caadr exp)))

(define (definition-value exp)
	(if (symbol? (cadr exp)) 
		(caddr exp)
      	(make-lambda (cdadr exp)  ; formal parameters
                   (cddr exp))))  ; body

; lambda
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp)) 
(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body) 
	(cons 'lambda (cons parameters body)))

; if
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
	(if (not (null? (cdddr exp))) 
		(cadddr exp)
		'false))
 

(define (make-if predicate consequent alternative)
     (list 'if predicate consequent alternative))

(define (begin? exp) (tagged-list? exp 'begin)) 
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq))) 
(define (first-exp seq) (car seq)) 
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq) 
	(cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
		  (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

(define (application? exp) (pair? exp)) 
(define (operator exp) (car exp)) 
(define (operands exp) (cdr exp)) 
(define (no-operands? ops) (null? ops)) 
(define (first-operand ops) (car ops)) 
(define (rest-operands ops) (cdr ops))

#|
(cond ((> x 0) x)
	((= x 0) (display 'zero) 0) 
	(else (- x)))


(if (> x 0) 
	x
	(if (= x 0)
		(begin (display 'zero) 0) 
		(- x)))
|#

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
            	(make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))











;;; set env

(define (true? x) (not (eq? x false))) 
(define (false? x) (eq? x false))


(define (make-procedure parameters body env) 
	(list 'procedure parameters body env))


(define (compound-procedure? p) 
	(tagged-list? p 'procedure))


(define (procedure-parameters p) (cadr p)) 
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))


#|
(lookup-variable-value ⟨var⟩ ⟨env⟩)
(extend-environment ⟨variables⟩ ⟨values⟩ ⟨base-env⟩)
(define-variable! ⟨var⟩ ⟨value⟩ ⟨env⟩)
(set-variable-value! ⟨var⟩ ⟨value⟩ ⟨env⟩)
|#


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







(define primitive-procedures 
	(list (list 'car car) 
		  (list 'cdr cdr)
		  (list 'cons cons) 
		  (list 'null? null?)
		  (list 'map map)
		  (list 'list list) 
		  (list '+ +)
		  (list '> >)
		  (list '= =)
		  (list '- -)
		  (list 'not not)
		  (list 'eq? eq?)
		  (list 'even? even?)
		  ))

(define (primitive-procedure? proc) 
	(tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cadr proc))

(define (primitive-procedure-names) 
	(map car primitive-procedures))

(define (primitive-procedure-objects)
	(map (lambda (proc) (list 'primitive (cadr proc)))
	primitive-procedures))


(define (apply-primitive-procedure proc args) 
	(apply-in-underlying-scheme
   		(primitive-implementation proc) args))


(define (setup-environment) 
	(let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
	    (define-variable! 'true true initial-env)
	    (define-variable! 'false false initial-env)
		initial-env)
	)

(define the-global-environment (setup-environment))






#|

(define input-prompt ";;; M-Eval input:") 
(define output-prompt ";;; M-Eval value:") 
(define (driver-loop)
	(prompt-for-input input-prompt) 
	(let ((input (read)))
		(let ((output (eval input the-global-environment))) 
			(announce-output output-prompt)
			(user-print output)))
  (driver-loop))

(define (prompt-for-input string)
	(newline) (newline) (display string) (newline))
(define (announce-output string) 
	(newline) (display string) (newline))

(define (user-print object)
	(if (compound-procedure? object)
	      (display (list 'compound-procedure
	                     (procedure-parameters object)
	                     (procedure-body object)
	                     '<procedure-env>))
	      (display object)))



|#









(define input-prompt ";;; Amb-Eval input:") 
(define output-prompt ";;; Amb-Eval value:")

(define (driver-loop)
	(define (internal-loop try-again)
		(prompt-for-input input-prompt) 
		(let ((input (read)))
			(if (eq? input 'try-again) 
				(try-again)
				(begin
					(newline) (display ";;; Starting a new problem ") 
					(ambeval
					 input
					 the-global-environment

					 ;; ambeval success
					(lambda (val next-alternative)
              			(announce-output output-prompt)
               			(user-print val)
               			(internal-loop next-alternative))

					;; ambeval failure 
					(lambda ()
               			(announce-output
                		";;; There are no more values of")
               			(user-print input)
               			(driver-loop)))))))
  	(internal-loop
		(lambda ()
			(newline) (display ";;; There is no current problem") 
			(driver-loop))))


#|
(ambeval (amb 1 2 3)  env success failure)
((analyze (amb 1 2 3))  env success  failure)
|#


(define (prompt-for-input string)
	(newline) (newline) (display string) (newline))
(define (announce-output string) 
	(newline) (display string) (newline))

(define (user-print object)
	(if (compound-procedure? object)
	      (display (list 'compound-procedure
	                     (procedure-parameters object)
	                     (procedure-body object)
	                     '<procedure-env>))
	      (display object)))

(driver-loop)


;(define (require p) (if (not p) (amb)))


#|
(define (shuffle-list lst)
  (let loop ((remaining lst) (shuffled '()))
    (if (null? remaining)
        shuffled
        (let* ((random-index (random (length remaining)))
               (selected-item (list-ref remaining random-index))
               (new-remaining (append (take remaining random-index)
                                      (drop remaining (+ random-index 1)))))
          (loop new-remaining (cons selected-item shuffled))))))

(define lst '(1 2 3 4 5 6 7 8 9 10))

(define shuffled-list (shuffle-list lst))

(display shuffled-list)



(define (require p) (if (not p) (amb)))



(define (an-element-of items)
	(require (not (null? items)))
	(amb (car items) (an-element-of (cdr items))))


(define (prime-sum-pair list1 list2) (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    (require (prime? (+ a b)))
    (list a b)))




(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
  (permanent-set! count (+ count 1))
  (require (not (eq? x y)))
  (list x y count))


|#

#|
;;; Starting a new problem 
;;; Amb-Eval value:
(a b 1)

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
(a c 1)

|#


(define (prime-sum-pair list1 list2) 
	(let ((a (an-element-of list1))
        (b (an-element-of list2)))
	    (require (prime? (+ a b)))
	    (list a b)))


(let ((pairs '())) 
	(if-fail
		(let ((p (prime-sum-pair '(1 3 5 8)
								 '(20 35 110))))
		     (permanent-set! pairs (cons p pairs))
		     (amb))
		   pairs))


((8 35) (3 110) (3 20))





