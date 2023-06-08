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


(define (tree->list tree)
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



(define (list->tree elements)
    (car (partial-tree elements (length elements))))


(define (partial-tree elts n) 
    (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2)))
            (let ((left-result
                    (partial-tree elts left-size)))
                (let ((left-tree (car left-result)) 
                        (non-left-elts (cdr left-result)) 
                        (right-size (- n (+ left-size 1))))
                    (let ((this-entry (car non-left-elts)) 
                        (right-result
                         (partial-tree
                          (cdr non-left-elts)
                          right-size)))
                        (let ((right-tree (car right-result)) 
                              (remaining-elts (cdr right-result))
                             )
                           (cons (make-tree this-entry
                                         left-tree
                                         right-tree)
                            remaining-elts)
                        )
                    )
                )
            )
        )
    )
)

(define (union-set-helper set1 set2)
    (cond ((null? set1) set2)
          ((null? set2) set1)

          (else 
                (let ((x1 (car set1)) (x2 (car set2)))
                    (cond ((= x1 x2)
                             (union-set-helper (cdr set1) set2)
                          )

                          ((< x1 x2)
                             (cons x1 (union-set-helper (cdr set1) set2))
                          )

                          ((> x1 x2)
                             (cons x2 (union-set-helper set1 (cdr set2)))
                          )
                    )
                )
          )
    )
)

(define (union-set tree1 tree2)
    (cond ((null? tree1) tree2)
          ((null? tree2) tree1)

          (else 
                 (let (
                         (set1 (tree->list tree1)) 
                         (set2 (tree->list tree2))
                      )

                      (list->tree (union-set-helper set1 set2))
                 )
          )

    )
)



(define (intersection-set-helper set1 set2) 
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                (cons x1 (intersection-set-helper (cdr set1)
                                           (cdr set2))))
              ((< x1 x2)
               (intersection-set-helper (cdr set1) set2))
              ((< x2 x1)
               (intersection-set-helper set1 (cdr set2)))))))


(define (intersection-set tree1 tree2)
    (if (or (null? tree1) (null? tree2)) 
        '()
    
             
        (let (
                (set1 (tree->list tree1)) 
                (set2 (tree->list tree2))
             )

            (list->tree (intersection-set-helper set1 set2))
        )

            

    )

)












#|

1 ]=> (union-set-help (list 1 3 5) (list 2 3 7))

;Value: (1 2 3 5 7)

1 ]=> (list->tree (list 1 3 5))

;Value: (3 (1 () ()) (5 () ()))

1 ]=> (list->tree (list 2 3 7))

;Value: (3 (2 () ()) (7 () ()))

1 ]=> (list->tree (list 1 2 3 5 7))

;Value: (3 (1 () (2 () ())) (5 () (7 () ())))

1 ]=> (union-set (list->tree (list 1 3 5)) (list->tree (list 2 3 7)))

;Value: (3 (1 () (2 () ())) (5 () (7 () ())))


(intersection-set (list->tree (list 1 3 5)) (list->tree (list 2 3 7)))
|#

(intersection-set (list->tree (list 1 3 5)) (list->tree (list 2 3 7)))






