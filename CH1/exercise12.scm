(define (Pascal level n)
	(if (or (= n 1) (= n level))
		1
		(+ (Pascal (- level 1) (- n 1)) (Pascal (- level 1) n))
	)
)


#|
1 ]=> (Pascal 5 1)

;Value: 1

1 ]=> (Pascal 5 2)

;Value: 4

1 ]=> (Pascal 5 3)

;Value: 6

1 ]=> (Pascal 5 4)

;Value: 4

1 ]=> (Pascal 5 5)

;Value: 1

|#