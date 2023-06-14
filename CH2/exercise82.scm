;比如有一种程序，能执行不同类型的数据，但是已经把所以的类型都
;转变为一种类型了，这个程序就不会被执行



(define (get-new-args args type-tags)
	(let ((args-length (length args)))
		(define (iter args)
			(if (null? args)
				false
				(let ((coercions (get-coercions (car args) type-tags)))
					(if (= (length coercions) (args-length))
						(map (lambda (coercion arg) (coercion arg)) coercions args)
						(iter (cdr args))
					)
                )
			)       
	    )
	    (iter type-tags)
	)
)

(define (get-coercions target type-tags)
	(if (null? type-tags)
		'()
		(if (= (car type-tags) target)
			(cons (lambda (x) x) (get-coercions target (cdr type-tags)))
			(let ((current->target (get-coercion (car type-tags) target)))
				(if (current->target)
					(cons current->target (get-coercions target (cdr type-tags)))
					'()
				)
			) 
		)
	)
)

(define (apply-generic op . args)
	(let ((type-tags (map type-tag args)))
		(let ((proc (get op type-tags))) 
			(if proc
            	(apply proc (map contents args))
 				(let ((new-args (get-new-args args) type-tags))
 					(if new-args
 						(let ((new-type-tags (map type-tags new-args)))
 							(let ((new-proc (get op new-type-tags)))
 								(apply new-proc (map contents new-args))
 							)
 						)
 					)
 					(error "No method for these types: APPLY-GENERIC" (list op type-tags)) 
 				)
            )
		)
	)
)










	













