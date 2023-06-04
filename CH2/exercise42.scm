(define nil '())

(define (accumulate op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high) 
	(if (> low high)
		nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
	(accumulate append nil (map proc seq)))



(define (queens board-size) 
	(define (queen-cols k)
		(if (= k 0)
			(list empty-board) 

			(filter
				(lambda (positions) (safe? k positions)) 

				(flatmap
					(lambda (rest-of-queens) 
						(map (lambda (new-row)
		                   (adjoin-position new-row k rest-of-queens))
		                   (enumerate-interval 1 board-size)
		                )
					)
		            (queen-cols (- k 1))
	            )
			)
		)
	)
  
   (queen-cols board-size)
)

(define empty-board '())



(define (safe? k positions)
	(cond ((= 1 k) true)
		  (else (let ((last (car positions)) (current (cadr positions)))
					(and (safe-helper last current) (safe? (- k 1) (cons (car positions) (cddr positions))))

		        )
		  )
	)
)


(define (safe-helper last current)
	(not (or (same-row? last current) (diagonal? last current)))

)


(define (same-row? last current)
	(= (car last) (car current))
)

(define (diagonal? last current)
	(let ((temp (/ (- (cdr last) (cdr current)) (- (car last) (car current)))))
		(or (= temp -1) (= temp 1))
	)
)



(define (adjoin-position new-row k rest-of-queens)
	(append (list (cons new-row k)) rest-of-queens)

)


(define (filter predicate sequence) 
	(cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
			(filter predicate (cdr sequence)))) 
        (else (filter predicate (cdr sequence)))))

(define x (list (cons 1 2) (cons 3 4)))

((6 . 8) (4 . 7) (1 . 6) (5 . 5) (8 . 4) (2 . 3) (7 . 2) (3 . 1))









