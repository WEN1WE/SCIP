(define (f x)
	(define (even? n) (if (= n 0) true (odd? (- n 1)))) 
	(define (odd? n) (if (= n 0) false (even? (- n 1)))) 
	⟨rest of body of f⟩)

(define (f x) 
	(letrec
		((even? (lambda (n)
			(if (= n 0) true (odd? (- n 1)))))
		(odd? (lambda (n)
			(if (= n 0) false (even? (- n 1))))))
	⟨rest of body of f⟩))

(letrec
	((fact (lambda (n)
		(if (= n 1) 1 (* n (fact (- n 1))))))) 
	(fact 10))

(let ((fact '*unassigned*))
	(set! fact (lambda (n) (if (= n 1) 1 (* n (fact (- n 1))))))
	(fact 10)
)

(define (letrec->let exp)
	(define let-vars (map (lambda (x) (list (car x) '*unassigned*) (letrec-var-vals exp))))
	(define let-set! (map (lambda (x) (cons 'set! x) (letrec-var-vals exp))))

	(cons 'let (cons let-vars (append (let-set!) (letrec-body exp))))

)


(define (letrec-var-vals exp)
	(cadr exp)
)

(define (letrec-body exp)
	(cddr exp)
)


#|

(let
	((fact (lambda (n)
		(if (= n 1) 1 (* n (fact (- n 1))))))) 
	(fact 10))


((lambda (fact)
	(fact 10)
) (lambda (n) (if (= n 1) 1 (* n (fact (- n 1))))))

(lambda (n) (if (= n 1) 1 (* n (fact (- n 1))))) 是在程序外部创立的，所以并不能知道内部定义的fact，所以会报错

|#

