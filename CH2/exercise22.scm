(define (square-list items) 
	(define (iter things answer)
		(if (null? things) 
			answer
        	(iter (cdr things)
              (cons (square (car things))
					answer))))

	(iter items nil))

#|
由于进行迭代的时候，是往前加东西，所以会出现相反的现象
|#

(define (square-list items)
	(define (iter things answer) 
		(if (null? things)
        	answer
        	(iter (cdr things)
              	(cons answer
                    (square (car things))))))
  	(iter items nil)
)

#|
cons 后面应该加入的是一个数字，而不是list

|#
