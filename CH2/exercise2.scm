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

(define (print-point p) 
	(newline)
	(display "(") 
	(display (x-point p)) 
	(display ",")
	(display (y-point p))
  	(display ")"))


(print-point (midpoint-segment (make-segment (make-point 2 4) (make-point 4 6)))) 




