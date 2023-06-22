
; ((node : (key value) left-branch right-branch))


(define (make-table)
  (list '*table*))

(define (get-key tree)
	(caar tree)
)

(define (get-value tree)
	(cdar tree)
)

(define (entry tree)
	(car tree)
)

(define (left-branch tree) (cadr tree)) 

(define (right-branch tree) (caddr tree)) 


(define (adjoin-set x set) 
	(cond ((null? set) (make-tree x '() '())) 
	     ((= (car x) (car (entry set))) set) 
	     ((< (car x) (car (entry set))) 
	      (make-tree (entry set) 
	                 (adjoin-set x (left-branch set)) 
	                 (right-branch set))) 
	     ((> (car x) (car (entry set))) 
	      (make-tree (entry set) 
	                 (left-branch set) 
	                 (adjoin-set x (right-branch set)))))) 

(define (make-tree entry left right) 
   (list entry left right)) 

(define (make-table)
	(let ((local-table (list '*table*)))
		(define (assoc key records)
			(cond ((null? records) false)
				  ((= key (get-value records)) (entry records))
				  ((< key (get-value records)) (assoc key (left-branch records)))
				  ((> key (get-value records)) (assoc key (right-branch records)))

			) 
		)

		(define (lookup key table)
			(let ((record (assoc key (cdr table))))
				(if record
					(cdr record)
					false)))


		(define (insert! key value table)
			(let ((record (assoc key (cdr table))))
				(if record
					(set-cdr! record value) 
					(set! local-table (adjoin-set (cons key value) local-table)
			'ok)


		(define (dispatch m)
			(cond ((eq? m 'lookup) lookup)
			((eq? m 'insert!) insert!)
			(else (error "Unknown operation: TABLE" m))))

		dispatch
	)
)






















