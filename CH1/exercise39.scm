(define (cont-frac n d k)
	(define (cont-frac-help i)
		(if (= i k)
			(/ (n i) (d i))
			(/ (n i) (+ (d i) (cont-frac-help (+ i 1)))) 
		)
	)
	(cont-frac-help 1)
)

(define (tan-cf x k)
	(define (n i) 
		(if (= i 1)
			(* 1.0 x)
			(* -1.0 (square x)) 
		) 
	)

	(define (d i)
		(- (* 2.0 i) 1.0)
	)

	(cont-frac n d k)

)

#|
1 ]=> (tan-cf 2 10)

;Value: -2.1850398632626273

|#