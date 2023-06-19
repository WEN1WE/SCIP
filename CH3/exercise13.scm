(define (make-cycle x) 
	(set-cdr! (last-pair x) x) x)

(define z (make-cycle (list 'a 'b 'c)))


; 这个x首尾相接
