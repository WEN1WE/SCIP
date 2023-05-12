#|

;;; 对于特别大的数字
1 ]=> (trace sqrt-iter)
1 ]=> (sqrt 10000000000000)                                               ;;; 13个0
[Entering #[compound-procedure 2 sqrt-iter]
    Args: 3162277.6601683795
          10000000000000]
[Entering #[compound-procedure 2 sqrt-iter]
    Args: 3162277.6601683795
          10000000000000]
[Entering #[compound-procedure 2 sqrt-iter]
    Args: 3162277.6601683795
          10000000000000]                                                  ;;;   程序一直没法结束

1 ]=>  (- (* 3162277.6601683795 3162277.6601683795) 10000000000000)        ;;;  可以看出没法接近误差0.01，所以一直循环
;Value: .001953125


;;; 对于特别小的数字
1 ]=> (sqrt 0.00000001)
;Value: .03125010656242753
1 ]=> (- 0.00000001 (* 0.03125010656242753 0.03125010656242753))
;Value: -9.765591601630759e-4                                              ;;; 可以看出，由于数字太小，立马就满足了误差0.01   

;;; 总体来说，误差需要动态变化，才能满足条件
|#


#|
(define (sqrt-iter guess x) 
	(if (good-enough? guess x)
    	guess
    	(sqrt-iter (improve guess x) x)))
|#

(define (sqrt-iter guess-old guess-new x)
	(if (good-enough? guess-old guess-new)
		guess-new
		(sqrt-iter guess-new (improve guess-new x) x)))

(define (improve guess x) 
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? guess-old guess-new)
	(< (/ (abs (- guess-new guess-old)) guess-old) 0.001))

#|
(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))
|#

(define (sqrt x)
	(sqrt-iter 1.0 (* 1.0 x) (* 1.0 x)))


#|
(define (new-if predicate then-clause else-calse)
	(cond (predicate then-clause)
		  (else else-calse))) 
|#

