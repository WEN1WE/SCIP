(define (make-table)
	(let ((local-table (list '*table*)))
		(define (assoc key records)
			(cond ((null? records) false)
				((equal? key (caar records)) (car records)) 
				(else (assoc key (cdr records)))))


		(define (lookup keys)
			(define (iter rest-keys rest-table)
				(if (null? rest-keys)
					(cdr rest-table)
					(let ((subtable (assoc (car keys) (cdr local-table))))
						(if subtable
							(iter (cdr rest-keys) subtable)
							false
						)
					)
				)
			)
			(iter keys local-table)
		)

		(define (generate keys value)
			(if (null? (cdr keys))
				(cons (car keys) value)
				(list (car keys) (generate (cdr keys) value))
			)
		)

		(define (insert! value keys)
			(define (iter rest-keys rest-table)
				(if (null? rest-keys)
					(set-cdr! rest-table value)
					(let ((subtable (assoc (car keys) (cdr local-table))))
						(if subtable
							(iter (cdr rest-keys) subtable)
							(set-cdr! rest-table
								      (cons (generate rest-keys value)
								      (cdr rest-table))
							)

						)

					)
				)
			)
			(iter keys local-table)
		)	


		(define (dispatch m)
			(cond ((eq? m 'lookup) lookup)
			((eq? m 'insert!) insert!)
			(else (error "Unknown operation: TABLE" m))))

		dispatch
	)
)


 (define (insert! x value . keys) ((x 'insert!) value keys)) 
 (define (lookup x . keys) ((x 'lookup) keys)) 
 (define t (make-table))


#|
1 ]=> (insert! t 1 'a)

;Unspecified return value

1 ]=> (lookup t 'a)

;Value: 1

1 ]=> (insert! t 1 'a 'b)

;Unspecified return value

1 ]=> (lookup t 'a)

;Value: 1

1 ]=> (lookup t 'b)

;Value: #f

1 ]=> (lookup t 'a 'b)

;Value: 1

1 ]=> (insert! t 2 'a 'b 'c)

;Unspecified return value

1 ]=> (lookup t 'a 'b 'c)

;Value: 2



|#







