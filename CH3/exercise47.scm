
(define (make-serializer n) 
	(let semaphore (make-semaphore n)
		(lambda (p)
			(define (semaphore-p . args)
				(semaphore 'acquire)
				(let ((val (apply p args)))
				  (semaphore 'release)
				  val)
		    )
		    semaphore-p
	    )
	)
)


(define (make-semaphore n)
	(let ((left n))
		(define (the-semaphore m)
			(cond ((eq? m 'acquire)
						(if (= left 0)
							(the-semaphore 'acquire)
							(set! left (- left 1))

						)
				  ((eq? m 'release)
				  	    (set! left (+ 1 left))

				  )


			)

		)
		the-semaphore
	)
)


(define (test-and-set! n) 

)


#|
(let protected (make-serializer n)

)

(protected withdraw)
(protected deposit)


|#




