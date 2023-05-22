
(define (cont-frac n d k)
	(define (cont-frac-help i)
		(if (= i k)
			(/ (n i) (d i))
			(/ (n i) (+ (d i) (cont-frac-help (+ i 1)))) 
		)
	)
	(cont-frac-help 1)
)

(define (De-d i)
	(let ((temp (remainder i 3)))
		(if (= temp 2)
			(/ (* 2 (+ i 1)) 3)
			1

		) 
	)
)



(+ 2 (cont-frac (lambda (i) 1.0) De-d 10))


#|
;Loading "exercise38.scm"... done
;Value: 2.7182817182817183

|#