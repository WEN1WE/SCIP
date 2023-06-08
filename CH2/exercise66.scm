(define (lookup given-key set-of-records) 
	(cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
		(else (lookup given-key (cdr set-of-records)))))



(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree)) 

(define (right-branch tree) (caddr tree)) 

(define (make-tree entry left right)
	(list entry left right))

(define (lookup given-key set-of-records)
	(cond ((null? set-of-records) false)
		((= x (key (entry set-of-records))) (entry element-of-set))
		((< x (key (entry set-of-records)))
			(lookup given-key (left-branch set-of-records))
		)
		((> x (key (entry set-of-records)))
			(lookup given-key (right-branch set-of-records))
		)
	) 
)

(define (element-of-set? x set) 
	(cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))


