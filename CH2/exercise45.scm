
(define (square-of-four tl tr bl br) 
	(lambda (painter)
		(let (
				(top (beside (tl painter) (tr painter))) 
				(bottom (beside (bl painter) (br painter)))
			 )

	  		(below bottom top)
	  	)
	)

)

(define (flipped-pairs painter)
	(let ((painter2 (beside painter (flip-vert painter))))
		(below painter2 painter2)))


(define (square-limit painter n)
	(let ((quarter (corner-split painter n)))
		(let ((half (beside (flip-horiz quarter) quarter))) 
			(below (flip-vert half) half))))

(define (flipped-pairs painter)
	(let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

(define (flipped-pairs painter)
	(let 
		(
			(combine4 (square-of-four identity flip-vert identity flip-vert))
		)
    	(combine4 painter)
    )
)

(define (square-limit painter n)
	(let 
		(
			(combine4 (square-of-four flip-horiz identity rotate180 flip-vert))
		)
	(combine4 (corner-split painter n))
	)
)

(define (flip-vert painter)

)

(define (flip-horiz painter)

)

(define (rotate180 painter)

)

(define (right-split painter n) 
	(if (= n 0)
		painter
		(let ((smaller (right-split painter (- n 1))))
        	(beside painter (below smaller smaller)))))


(define (up-split painter n)
	(if (= n 0)
		painter
		(let ((smaller (up-split painter (- n 1))))
			(below painter (beside smaller smaller))
		) 
	) 
)

(define right-split (split beside below)) 
(define up-split (split below beside))


(define (split op1 op2)
	(lambda (painter n)
		(if (= n 0)
			painter
			(let 
				((smaller ((split op1 op2) painter (- n 1))))
				
				(op1 painter (op2 smaller smaller))
			)

		) 
	) 
)














