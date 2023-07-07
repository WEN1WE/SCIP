(define (integers-starting-from n)
	(cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 10)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)





(define (interleave s1 s2) 
	(if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))


(define (pairs s t) 
	(interleave
		(stream-map (lambda (x) (list (stream-car s) x)) 
			        t)
		(pairs (stream-cdr s) (stream-cdr t))))

; 程序无法停止 流都会计算出第一项停止


#|
(1 1)    (2 2)     (3 3)

(1 2)    (2 3)
 
(1 3)    (2 4)

(1 4)    (2 5)



|#