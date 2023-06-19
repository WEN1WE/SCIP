(define (append! x y) 
	(set-cdr! (last-pair x) y) x)

(define (last-pair x)
	(if (null? (cdr x)) x (last-pair (cdr x))))


(define x (list 'a 'b)) 
(define y (list 'c 'd)) 
(define z (append x y))


#|
1 ]=> z

;Value: (a b c d)

1 ]=> (cdr x)

;Value: (b)

1 ]=> (define w (append! x y))

;Value: w

1 ]=> w

;Value: (a b c d)

1 ]=> (cdr x)

;Value: (b c d)






|#