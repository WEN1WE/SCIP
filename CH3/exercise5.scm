

(define rand (let ((x random-init)) 
	(lambda ()
		(set! x (rand-update x)) 
		x)))

(define (estimate-pi trials)
	(sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
	(= (gcd (rand) (rand)) 1))


(define (monte-carlo trials experiment)
	(define (iter trials-remaining trials-passed)
		(cond ((= trials-remaining 0)
			  (/ trials-passed trials))

	          ((experiment)
	           (iter (- trials-remaining 1)
					 (+ trials-passed 1))) 
	          (else
	          	(iter (- trials-remaining 1)
	                 trials-passed)))
	)
    (iter trials 0)
)


#|
(define (estimate-pi trials)
	(sqrt (/ 6 (random-gcd-test trials random-init))))


(define (random-gcd-test trials initial-x) 
	(define (iter trials-remaining trials-passed x)
		(let ((x1 (rand-update x))) 
			(let ((x2 (rand-update x1)))
				(cond ((= trials-remaining 0) 
					   (/ trials-passed trials))
                      ((= (gcd x1 x2) 1)
                      (iter (- trials-remaining 1)
                            (+ trials-passed 1)
							x2)) 
                      (else
               			(iter (- trials-remaining 1)
                     		trials-passed
                     		x2))))))
    (iter trials 0 initial-x)
)
|#


(define (random-in-range low high) 
	(let ((range (- high low)))
    	(+ low (random range))))


(define (estimate-integral P x1 x2 y1 y2 trials)
	(let ((area (* (- x2 x1) (- y2 y1))))
		(* area (monte-carlo trials (lambda () (P (random-in-range x1 x2) (random-in-range y1 y2)))))
	)
)

(define (circle-test x y)
	(<= (+ (square x) (square y)) 1)
)

(define (estimate-pi trials)
	(estimate-integral circle-test -1.0 1.0 -1.0 1.0 trials)
)


#|

1 ]=> (estimate-pi 10)

;Value: 3.2

1 ]=> (estimate-pi 100)

;Value: 3.4

1 ]=> (estimate-pi 1000)

;Value: 3.18

1 ]=> (estimate-pi 10000)

;Value: 3.1652


|#




