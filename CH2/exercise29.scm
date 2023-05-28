(define (make-mobile left right) 
	(list left right))

(define (make-branch length structure) 
	(list length structure))

(define (left-branch mobile)
	(car mobile)
)

(define (right-branch mobile)
	(car (cdr mobile))
)

(define (branch-length branch)
	(car branch)
)

(define (branch-structure branch)
	(car (cdr branch))
)

(define (total-weight mobile)
	(if (not (pair? mobile))
		mobile
		(+ (total-weight (branch-structure (left-branch mobile))) (total-weight (branch-structure (right-branch mobile))))
	)
)

(define (balanced? mobile)
	(cond ((not (pair? mobile)) true)
		  (else
		  	(cond ((not (and (balanced? (branch-structure (left-branch mobile)))
							 (balanced? (branch-structure (right-branch mobile))))) false) 
		  		  (else 
		  		  		(let (
								(l1 (branch-length (left-branch mobile)))
								(l2 (branch-length (right-branch mobile)))
								(w1 (total-weight (branch-structure (left-branch mobile))))
								(w2 (total-weight (branch-structure (right-branch mobile))))

				 			 )
		  		  			 (= (* l1 w1) (* l2 w2))
						)

		  		  )

		  	)

		 )		  
	)
)


(define test1 (list (list 10 50) (list 5 100)))


#|
只需要改变选择函数就可以


|#


(define mob
    (make-mobile
       (make-branch
             100
             (make-mobile
                      (make-branch 100 1)
                      (make-branch 100 (make-mobile (make-branch 100 2) (make-branch 100 3)))
             )
       )
       (make-branch
             100
             (make-mobile
                      (make-branch 100 (make-mobile (make-branch 100 4) (make-branch 100 5)))
                      (make-branch 100 6)                         
             )
       )
  )
)
