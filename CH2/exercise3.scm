

(define (make-segment p1 p2)
	(cons p1 p2)
)

(define (start-segment segment)
	(car segment)
)

(define (end-segment segment)
	(cdr segment)
)

(define (midpoint-segment segment)
	(cons (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
		  (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)
	)
)

(define (make-point x y)
	(cons x y)
)

(define (x-point p)
	(car p)
)

(define (y-point p)
	(cdr p)
)




(define (perimeter r)
	(let (
			(l (get-length r))
			(w (get-width r))
		 ) 
		(+ (* 2 l) (* 2 w))
	)
)

(define (area r)
	(let (
			(l (get-length r))
			(w (get-width r))
	     ) 
	    (* l w)
	)
)

(define (length L)
	(let (
			(x1 (x-point (start-segment L)))
			(x2 (x-point (end-segment L)))
			(y1 (y-point (start-segment L)))
			(y2 (y-point (end-segment L)))
		 )
		(sqrt (+ (square (- x1 x2)) (square (- y1 y2))))
	)
)

(define (get-length r)
	(length (length-rectangle r))
)

(define (get-width r)
	(length (width-rectangle r))
)


#|
方法1 用线段构造

(define (make-rectangle s1 s2)
	(cons s1 s2)
)

(define (length-rectangle r)
	(car r)
)

(define (width-rectangle r) 
	(cdr r)
)


;;; 在let中 无法使用刚定义的变量，再定义变量
(define (test x1 y1 x2 y2 x3 y3)
	(let (
			(s1 (make-segment (make-point x1 y1) (make-point x2 y2)))
			(s2 (make-segment (make-point x2 y2) (make-point x3 y3)))
			
		 )
		(area (make-rectangle s1 s2))

	)
)
;;; 1 ]=> (test 2 0 0 0 0 3) ;Value: 6
|#


(define (make-rectangle p1 p2 p3)
	(cons (cons p1 p3) p2)
)

(define (length-rectangle r)
	(make-segment (car (car r)) (cdr r))
)

(define (width-rectangle r)
	(make-segment (cdr (car r)) (cdr r))
)


(define (test x1 y1 x2 y2 x3 y3)
	(let (
			(p1 (make-point x1 y1))
			(p2 (make-point x2 y2))
			(p3 (make-point x3 y3))
		 )
		(area (make-rectangle p1 p2 p3))

	)
)

#|
1 ]=> (test 2 0 0 0 0 3)

;Value: 6

可以看出，2种构造方法， area  perimeter都没有变

|#




