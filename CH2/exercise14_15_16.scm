
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



(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))


(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))

#|
(define r1 (make-center-percent 10 0.05))
(define r2 (make-center-percent 2 0.05))
(mul-interval r1 r2)
(add-interval r1 r2)

|#



(par1 (make-center-percent 10 0.05) (make-center-percent 2 0.05))
;;;Value: (1.4325396825396826 . 1.9342105263157894)
(par2 (make-center-percent 10 0.05) (make-center-percent 2 0.05))
;;;Value: (1.5833333333333335 . 1.75)

(par1 (make-center-percent 10 0.1) (make-center-percent 2 0.1))
;;;Value: (1.2272727272727273 . 2.240740740740741)
(par2 (make-center-percent 10 0.1) (make-center-percent 2 0.1))
;Value: (1.4999999999999998 . 1.8333333333333335)

#|
可以看出par2的区间都会比par1小

(R1 * R2) / (R1 + R2),分子与分母有依赖关系，所以当分子选择最大，分母就是最大，不可能选择到最小

所以不确定的变量，只能出现一次，就如同原来设计的

这种缺陷没办法解决，除非每次表达式，每次估计不确定关系的时候，都是独立的


|#















