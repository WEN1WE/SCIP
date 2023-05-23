(define tolerance 0.00001)
(define dx 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2) 
		(< (abs (- v1 v2))
			tolerance)) 
	(define (try guess)
		(newline)
		(display guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
          		(try next))))
    (try first-guess))


(define (average-damp f)
	(lambda (x) (average x (f x))))

(define (average a b)
	(/ (+ a b) 2.0)
)

(define (compose f g)
	(lambda (x) (f (g x)))  
)

(define (repeated f n)
	(if (= 1 n)
		f
		(compose f (repeated f (- n 1))) 
	)
)

(define (pow x n)
	(if (= n 1)
		x
		(* x (pow x (- n 1)))
	)
)

(define (sqrt x)
	(fixed-point (average-damp (lambda (y) (/ x y))) 1.0))


(define (cube-root x)
	(fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

(define (forth-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y)))) 1.0)

)

(define (fifth-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y y)))) 1.0)

)

(define (sixth-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y y y)))) 1.0)

)

(define (seventh-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (pow y 6)))) 1.0)

)

(define (eighth-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y y y y y)))) 1.0)

)

(define (ninth-root x)
	(fixed-point ((repeated average-damp 2) (lambda (y) (/ x (* y y y y y y y y)))) 1.0)

)

;;; 可以运行
(define (15-root x)
	(fixed-point ((repeated average-damp 3) (lambda (y) (/ x (pow y 14)))) 1.0)

)


;;; 无限循环
(define (16-root x)
	(fixed-point ((repeated average-damp 3) (lambda (y) (/ x (pow y 15)))) 1.0)

)

#|
根据观察， index = repeated的次数， 则可以执行的范围为 2^index - 2^(index + 1) -1
例如 index = 3，则范围为8-15 root , 运行都正常

|#

(define (find-index n)
	(if (< n 2)
		0
		(+ 1 (find-index (/ n 2.0))) 
	)
)


(define (nth-root n x)
	(fixed-point ((repeated average-damp (find-index n)) (lambda (y) (/ x (pow y (- n 1))))) 1.0)

)








