(define (raise x) (apply-generic 'raise x))


;将数据对象x 提升到type
(define (raise-to x type)
	(let ((next (raise x)))
		(if next
			(if (= (type-tag next) type)
				next
				(raise-to next type)
			)
			false
		)
	)
)



(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags))) 
			(if proc
				(apply proc (map contents args)) 
				(if (and (= (length args) 2) (not (= (car type-tags) (cadr type-tags))))


					(let ((type1 (car type-tags)) 
						  (type2 (cadr type-tags)) 
						  (a1 (car args))
                          (a2 (cadr args)))

						  (let ((a1-up (raise-to a1 type2)))
						  		(if a1-up
						  			(apply-generic op a1-up a2)
						  			(apply-generic op a1 (raise-to a2 type1))
						  		)
						  )

					)

	                (error "No method for these types"
	                       (list op type-tags))
	            
			)
		)
	)
)