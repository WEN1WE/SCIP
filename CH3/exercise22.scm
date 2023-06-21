(define (make-queue) 
	(let ((front-ptr '()) (rear-ptr '()))
		(define (set-front-ptr! item)
			(set! front-ptr item) 
		)
		(define (set-rear-ptr! item)
			(set! rear-ptr item)
		)

		(define (empty-queue?)
			(null? front-ptr)
		)

		(define (front-queue)
			(if (empty-queue?)
				(error "FRONT called with an empty queue" front-ptr)
				(car front-ptr)
			)
		)

		(define (insert-queue! item) 
			(let ((new-pair (cons item '())))
				(cond ((empty-queue?) 
					  (set-front-ptr! new-pair) 
					  (set-rear-ptr! new-pair) 
					  front-ptr)

				     (else
		              (set-cdr! rear-ptr new-pair) 
		              (set-rear-ptr! new-pair) 
		              front-ptr))))

		(define (delete-queue!) 
			(cond ((empty-queue?)
				(error "DELETE! called with an empty queue") front-ptr) 
			  (else (set-front-ptr! (cdr front-ptr))
					front-ptr)))


		(define (dispatch m)
			(cond ((eq? m 'front-ptr) front-ptr)
				  ((eq? m 'rear-ptr) rear-ptr)
				  ((eq? m 'set-front-ptr!) set-front-ptr!)
				  ((eq? m 'set-rear-ptr!) set-rear-ptr!)
				  ((eq? m 'empty-queue?) (empty-queue?))		  
			      ((eq? m 'front-queue) (front-queue))
			      ((eq? m 'insert-queue!) insert-queue!)
			      ((eq? m 'delete-queue!) (delete-queue!))
			) 
		)
		dispatch
	)
)



(define (front-ptr queue) (queue 'front-ptr))
(define (rear-ptr queue) (queue 'rear-ptr))
(define (set-front-ptr! queue item) ((queue 'set-front-ptr!) item))
(define (set-rear-ptr! queue item) ((queue 'set-rear-ptr!) item))
(define (empty-queue? queue) (queue 'empty-queue?))
(define (front-queue queue) (queue 'front-queue))
(define (insert-queue! queue item) ((queue 'insert-queue!) item)) 
(define (delete-queue! queue) (queue 'delete-queue!))


; 本程序是纵向来看一个对象的


#|
1 ]=> (define q1 (make-queue)) 

;Value: q1

1 ]=> (insert-queue! q1 'a)

;Value: (a)

1 ]=> (insert-queue! q1 'b)

;Value: (a b)

1 ]=> (delete-queue! q1)

;Value: (b)

1 ]=> (delete-queue! q1)

;Value: ()

1 ]=> (insert-queue! q1 'a)

;Value: (a)

|#






