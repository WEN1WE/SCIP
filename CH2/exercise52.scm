(define v1 (make-vect 0.25 0))
(define v2 (make-vect 0.4 0))
(define v3 (make-vect 0.5 0.3))
(define v4 (make-vect 0.6 0))
(define v5 (make-vect 0.75 0))
(define v6 (make-vect 0.6 0.45))
(define v7 (make-vect 0 0.15))
(define v8 (make-vect 0 0.35))
(define v9 (make-vect 0.75 0.65))
(define v10 (make-vect 0.6 0.65))
(define v11 (make-vect 0.65 0.85))
(define v12 (make-vect 0.6 1))
(define v13 (make-vect 0.4 1))
(define v14 (make-vect 0.35 0.855))
(define v15 (make-vect 0.4 0.65))
(define v16 (make-vect 0.3 0.65))
(define v17 (make-vect 0.15 0.6))
(define v18 (make-vect 0 0.85))
(define v19 (make-vect 0 0.65))
(define v20 (make-vect 0.15 0.4))
(define v21 (make-vect 0.3 0.6))
(define v22 (make-vect 0.35 0.5))
(define v23 (make-vect 0.45 0.75))
(define v24 (make-vect 0.5 0.7))
(define v25 (make-vect 0.55 0.75))
(define s1 (make-segment v1 v2))
(define s2 (make-segment v2 v3))
(define s3 (make-segment v3 v4))
(define s4 (make-segment v4 v5))
(define s5 (make-segment v5 v6))
(define s6 (make-segment v6 v7))
(define s7 (make-segment v7 v8))
(define s8 (make-segment v8 v9))
(define s9 (make-segment v9 v10))
(define s10 (make-segment v10 v11))
(define s11 (make-segment v11 v12))
(define s12 (make-segment v12 v13))
(define s13 (make-segment v13 v14))
(define s14 (make-segment v14 v15))
(define s15 (make-segment v15 v16))
(define s16 (make-segment v16 v17))
(define s17 (make-segment v17 v18))
(define s18 (make-segment v18 v19))
(define s19 (make-segment v19 v20))
(define s20 (make-segment v20 v21))
(define s21 (make-segment v21 v22))
(define s22 (make-segment v22 v1))
(define s23 (make-segment v23 v24))
(define s24 (make-segment v24 v25))
(define seg-list (list s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20 s21 s22 s23 s24))



(define (corner-split painter n) 
	(if (= n 0)
		painter

		(let 
			 ( 
				(up (up-split painter (- n 1)))
			 	(right (right-split painter (- n 1)))
			 )

			 (let 
			 	  (
			 	  	(top-left (beside up up))
					(bottom-right (below right right)) 
					(corner (corner-split painter (- n 1)))
				  )

	          	(beside (below painter top-left)
	                  (below bottom-right corner))

	         )
		)
	)

)

(define (corner-split painter n) 
	(if (= n 0)
		painter

		(let 
			 ( 
			 	(right (right-split painter (- n 1)))
			 )

			 (let 
			 	  (
					(bottom-right (below right right)) 
					(corner (corner-split painter (- n 1)))
				  )

	          	(beside (up-split painter n)
	                  (below bottom-right corner))

	         )
		)
	)

)


(define (square-limit painter n)
	(let 
		(
			(combine4 (square-of-four identity flip-horiz  flip-vert rotate180 ))
		)
	(combine4 (corner-split painter n))
	)
)








