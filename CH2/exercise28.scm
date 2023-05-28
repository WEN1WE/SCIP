(define (fringe items)
	(if (null? items) 
		items
		(if (pair? (car items))
			(append (fringe (car items)) (fringe (cdr items)))
			(cons (car items) (fringe (cdr items))) 
		)
	)
)