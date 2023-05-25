
(define (add-interval x y)
	(make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))


(define (mul-interval x y)
	(let ((p1 (* (lower-bound x) (lower-bound y)))
		 (p2 (* (lower-bound x) (upper-bound y)))
         (p3 (* (upper-bound x) (lower-bound y)))
         (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))


(define (div-interval x y) 
  (if (and (>= 0 (upper-bound y)) (<= 0 (lower-bound y)))
    (error "Divide 0") 
    (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))
  )
)

(define (make-interval a b) (cons a b))

(define (upper-bound x)
	(max (car x) (cdr x))
)

(define (lower-bound x)
	(min (car x) (cdr x))
)

(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y)) (- (lower-bound y))))
)

(define (make-center-width c w) 
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (make-interval (* c (- 1 p)) (* c (+ 1 p)))

)

(define (percent i)
  (/ (width i) (center i))
)

(percent (make-center-percent 6.8 0.1))

#|
;Loading "exercise12.scm"... done
;Value: .10000000000000002

|#




