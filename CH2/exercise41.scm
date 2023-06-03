(define nil '())

(define (enumerate-interval low high) 
	(if (> low high)
		nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (unique-triples n)
	(accumulate append nil (accumulate append nil 
		(map 
			(lambda (i)
				(map 
					(lambda (j)
					    (map 
							(lambda (k) 
								(list i j k)
							) 
							(enumerate-interval 1 (- j 1))
						)
					)

			       (enumerate-interval 1 (- i 1))
			    )
		    )
			(enumerate-interval 1 n)
		)
	))
)



(define (equal-sum-triples n s)
	(define (equal-sum? triple)
		(= (+ (car triple) (cadr triple) (caddr triple)) s)
	)

	(filter equal-sum? (unique-triples n))
)

