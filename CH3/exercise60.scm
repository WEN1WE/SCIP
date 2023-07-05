(define (integrate-series series)
	(define (helper s i)
		(cons-stream (/ (stream-car s) i) (helper (stream-cdr s) (+ i 1)))
	)
	(helper series 1)
)

(define exp-series
	(cons-stream 1 (integrate-series exp-series)))

(define (negative series)
	(cons-stream (* -1 (stream-car series)) (negative (stream-cdr series)))
)

(define cosine-series (cons-stream 1 (negative (integrate-series sine-series))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))


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










(define (add-streams s1 s2) (stream-map + s1 s2))

(define (scale-stream stream factor) 
	(stream-map (lambda (x) (* x factor))
		stream))

(define (mul-series s1 s2)
	(cons-stream (* (stream-car s1) (stream-car s2)) 
		         (add-streams 
		         	(scale-stream (stream-cdr s2) (stream-car s1))
		         	(mul-series (stream-cdr s1) s2)
		         )
	)
)


(define x (mul-series sine-series sine-series))
(define y (mul-series cosine-series cosine-series))
(define z (add-streams x y))



#|

a0 a1 a2 a3 a4 ...
b0 b1 b2 b3 b4 ...



流的计算是一个正向的向后进行的过程，这个与递归有所不同，递归用栈来保存未计算完的量，然后到结尾返回

所以流就是保证第一个元素正确，然后保证计算下一个元素的程序正确，这样，流就能不停计算下去，并且保证正确
也就是说前面计算的正确性，保证了后面程序计算的正确性


|#







