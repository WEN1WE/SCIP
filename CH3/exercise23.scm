(define (front-ptr deque) (car deque)) 
(define (rear-ptr deque) (cdr deque)) 
(define (set-front-ptr! deque item)
	(set-car! deque item))
(define (set-rear-ptr! deque item)
	(set-cdr! deque item))



(define (make-deque) (cons '() '()))

(define (empty-deque? deque) 
	(null? (front-ptr deque)))

(define (front-deque deque) 
	(if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (cdr (front-ptr deque))))

(define (rear-deque deque) 
	(if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (cdr (rear-ptr deque))))

(define (set-next-ptr! node item)
	(set-cdr! (car node) item)
)

(define (set-last-ptr! node item)
	(set-car! (car node) item)
)

(define (next-ptr node)
	(cdar node)
)

(define (last-ptr node)
	(caar node)
)

(define (rear-insert-deque! deque item) 
	(let ((new-node (cons (cons '() '()) item)))
		(cond ((empty-deque? deque) 
			  (set-front-ptr! deque new-node) 
			  (set-rear-ptr! deque new-node) 
			  deque)

		     (else
              (set-next-ptr! (rear-ptr deque) new-node) 
              (set-last-ptr! new-node (rear-ptr deque))
              (set-rear-ptr! deque new-node) 
              deque))))


(define (front-insert-deque! deque item) 
	(let ((new-node (cons (cons '() '()) item)))
		(cond ((empty-deque? deque) 
			  (set-front-ptr! deque new-node) 
			  (set-rear-ptr! deque new-node) 
			  deque)

		     (else
              (set-next-ptr! new-node (front-ptr deque))
              (set-last-ptr! (front-ptr deque) new-node) 
              (set-front-ptr! deque new-node) 
              deque))))


(define (front-delete-deque! deque) 
	(cond ((empty-deque? deque)
		(error "DELETE! called with an empty deque" deque)) 
	  (else (set-front-ptr! deque (next-ptr (front-ptr deque)))
			deque)))


(define (rear-delete-deque! deque) 
	(cond ((empty-deque? deque)
		(error "DELETE! called with an empty deque" deque)) 
	  (else (set-rear-ptr! deque (last-ptr (rear-ptr deque)))
			deque)))


(define q (make-deque))
(front-insert-deque! q 'b)
(front-insert-deque! q 'a)
(rear-insert-deque! q 'c)
(front-deque q)   ; a
(rear-deque q)    ; c
(front-delete-deque! q)
(front-deque q)   ; b
(rear-deque q)    ; c
(rear-delete-deque! q) 
(front-deque q)   ; b
(rear-deque q)    ; b








