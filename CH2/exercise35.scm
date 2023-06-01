(define nil '())

#|
(define (accumulate op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(accumulate op initial (cdr sequence)))))
|#

#|

(define (count-leaves x) 
	(cond ((null? x) 0)
		((not (pair? x)) 1)
		(else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
|#

#|

(define (map proc items) 
	(if (null? items)
		nil
      	(cons (proc (car items))
            (map proc (cdr items)))))
|#


(define (count-leaves t)
	(accumulate + 0 (map (lambda (sub-t)
								(if (pair? sub-t)
									(count-leaves sub-t)
									1
								)
		                      )
						      t
					 )
	)

)

(define (count-leaves-test t)
	(accumulate cons nil (map (lambda (sub-t)
								(if (pair? sub-t)
									2
									1
								)
		                      )
						      t
					 )
	)

)



(define x (cons (list 1 2) (list 3 4)))

#|
本题模仿的程序是p153 scale-tree
|#




