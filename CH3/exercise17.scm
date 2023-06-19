(define (element-of-set? x set) 
	(cond ((null? set) false)
		((equal? x (car set)) true)
		(else (element-of-set? x (cdr set)))))

(define (memq item x) 
	(cond ((null? x) false)
		((eq? item (car x)) x) 
		(else (memq item (cdr x)))))



(define (count-pairs x) 
	(let ((auxiliary '()))
		(define (count-helper p) 
			(if (not (pair? p))
		      0
		      (if (element-of-set? p auxiliary)
		      	  0
		      	  (begin (set! auxiliary (cons p auxiliary)) 
		      	  	     (+ (count-helper (car p))
		                    (count-helper (cdr p))
		                    1
		                 )
		      	  )
		      )

		    )
		)
		(count-helper x)
	)
)




(define x (list 1))
(define y (list 2))
(define z (list 3))

(set-car! x y)
(set-cdr! x y)

(set-car! y z)
(set-cdr! y z)
