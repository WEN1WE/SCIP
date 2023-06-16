
将y表达式转变为x表达式
(x + 1) * y  -----> y * x + y

(define (convert poly var)
	(if (= (variable poly) var)
		poly
		(let ((terms (term-list poly)))
			(let ((first (first-term terms))
				  (rest (rest-term terms))
				 )

				(let ((first-o (order first))
                      (first-c (coeff first))
					 )
					(mul  ((convert first-c))) 

				)

			)


		)
	)
)




(make-polynomial var 
	            (list (make-term 0 
	            	            (make-polynomial (variable poly) 
	            	            	             (list (make-term first-o 1))))

		







