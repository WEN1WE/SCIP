(define (a-pythagorean-triple-between low high) 
	(let ((i (an-integer-between low high))
			(hsq (* high high)))
		(let ((j (an-integer-between i high)))
			(let ((ksq (+ (* i i) (* j j)))) 
				(require (>= hsq ksq))
				(let ((k (sqrt ksq)))
          			(require (integer? k))
          			(list i j k))))))

;是的，sqrt的运用，让程序少了一次循环