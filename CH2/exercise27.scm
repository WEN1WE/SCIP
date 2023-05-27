(define (reverse items)
	(if (null? items)
		items
		(append (reverse (cdr items)) (cons (car items) '())) 
	)
)

(define (deep-reverse items)
	(if (null? items)
		items
		(if (pair? (car items))
			(append (deep-reverse (cdr items)) (cons (deep-reverse (car items)) '()))
			(append (deep-reverse (cdr items)) (cons (car items) '())) 
		)	
	)
)

(define x (list (list 1 2) (list 3 4)))