(define (count-pairs x) 
	(if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(define x (list 1))
(define y (list 2))
(define z (list 3))

(set-car! x y)
(set-cdr! x y)

(set-car! y z)
(set-cdr! y z)

#|
1 ]=> (count-pairs x)

;Value: 7

如果有循环，就不会返回

|#