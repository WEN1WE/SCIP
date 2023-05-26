(define nil '())


#|
(define (square-list items) 
	(if (null? items)
		nil
		(cons (square (car items)) (square-list (cdr items)))
	)
)
|#

(define (square-list items)
	(map square items)
)


(square-list (list 1 2 3 4))

;Loading "exercise21.scm"... done
;Value: (1 4 9 16)