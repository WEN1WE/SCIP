


(define (add-streams s1 s2) (stream-map + s1 s2))


(define (mul-streams s1 s2) (stream-map * s1 s2))

(define (integers-starting-from n)
	(cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))


(define factorials
	(cons-stream 1 (mul-streams (stream-cdr integers) factorials)))

#|

       2    3    4       (stream-cdr integers) 
       1    2    6       factorials  
   1   2    6    24      factorials


|#






























































































