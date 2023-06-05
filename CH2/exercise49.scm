(define (segments->painter segment-list) 
	(lambda (frame)
		(for-each
			(lambda (segment)
       			(draw-line
	        		((frame-coord-map frame)
	         		(start-segment segment))

	        		((frame-coord-map frame)
	         		(end-segment segment))
         		)
         	)

            segment-list
        )
	)
)

(define v1 (make-vect 0 0))
(define v2 (make-vect 0 1))
(define v3 (make-vect 1 0))
(define v4 (make-vect 1 1))
(define s1 (make-segment v1 v2))
(define s2 (make-segment v1 v3))
(define s3 (make-segment v2 v4))
(define s4 (make-segment v3 v4))
(define seg-list (list s1 s2 s3 s4))


(define v1 (make-vect 0 0))
(define v2 (make-vect 0 1))
(define v3 (make-vect 1 0))
(define v4 (make-vect 1 1))
(define s1 (make-segment v2 v3))
(define s2 (make-segment v1 v4))
(define seg-list (list s1 s2))

(define v1 (make-vect 0.5 0))
(define v2 (make-vect 1 0.5))
(define v3 (make-vect 0.5 1))
(define v4 (make-vect 0 0.5))
(define s1 (make-segment v1 v2))
(define s2 (make-segment v2 v3))
(define s3 (make-segment v3 v4))
(define s4 (make-segment v4 v1))
(define seg-list (list s1 s2 s3 s4))


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
(define s22 (make-segment v22 v23))
(define seg-list (list s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20 s21 s22))


; 将基础框里的v 转变为frame中的v

(define (frame-coord-map frame) 
	(lambda (v)
	    (add-vect
	     	(origin-frame frame)
	     	(add-vect 
	     			(scale-vect (xcor-vect v) (edge1-frame frame))
	                (scale-vect (ycor-vect v) (edge2-frame frame))
	        )
	    )
    )

)


; frame 的定义
(define (make-frame origin edge1 edge2) 
	(cons origin (cons edge1 edge2)))


(define (origin-frame frame)
	(car frame)
)

(define (edge1-frame frame) 
	(cadr frame)
)

(define (edge2-frame frame) 
	(cddr frame)
)


; 片段的定义
(define (make-segment v1 v2)
	(cons v1 v2)
)

(define (start-segment seg)
	(car seg)
)

(define (end-segment seg)
	(cdr seg)
)



; 向量的定义
(define (make-vect x y)
	(cons x y) 
)

(define (xcor-vect v)
	(car v)
)

(define (ycor-vect v)
	(cdr v)
)

(define (add-vect v1 v2)
	(make-vect (+ (xcor-vect v1) (xcor-vect v2)) (+ (ycor-vect v1) (ycor-vect v2))) 
)

(define (sub-vect v1 v2)
	(make-vect (- (xcor-vect v1) (xcor-vect v2)) (- (ycor-vect v1) (ycor-vect v2))) 
)

(define (scale-vect v s)
	(make-vect (* s (xcor-vect v)) (* s (ycor-vect v)))
)