(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree)) 

(define (right-branch tree) (caddr tree)) 

(define (make-tree entry left right)
	(list entry left right))

(define (element-of-set? x set) 
	(cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))


(define (adjoin-set x set)
	(cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))

         (make-tree (entry set) 

         	        (left-branch set)
                    (adjoin-set x (right-branch set))))))



(define (tree->list-1 tree) 
	(if (null? tree)
		'()
        (append (tree->list-1 (left-branch tree))
                (cons (entry tree) (tree->list-1 (right-branch tree)))
        )
    )

) 




(define (tree->list-2 tree)
	(define (copy-to-list tree result-list) 
		(if (null? tree)
        	result-list
	        (copy-to-list (left-branch tree)
	                      (cons (entry tree) 
	                      	    (copy-to-list (right-branch tree) result-list))
	        )
	    )
	)


	(copy-to-list tree '())
)

(define tree (make-tree 7 '() '()))
(define tree (adjoin-set 9 tree))
(define tree (adjoin-set 11 tree))
(define tree (adjoin-set 3 tree))
(define tree (adjoin-set 5 tree))
(define tree (adjoin-set 1 tree))

#|
两个程序的输出相同
第一个程序，append需要花费时间


|#








