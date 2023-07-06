(stream-filter
	(lambda (pair) (prime? (+ (car pair) (cadr pair)))) 
	int-pairs)

#|
(stream-map (lambda (x) (list (stream-car s) x)) 
	(stream-cdr t))

(define (pairs s t) 
	(cons-stream
		(list (stream-car s) (stream-car t))


		(⟨combine-in-some-way⟩
			(stream-map (lambda (x) (list (stream-car s) x))
	                 (stream-cdr t))
	        (pairs (stream-cdr s) (stream-cdr t)))
	)
)

|#


(define (interleave s1 s2) 
	(if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))


(define (pairs s t) (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
		(stream-map (lambda (x) (list (stream-car s) x)) 
			        (stream-cdr t))
        (pairs (stream-cdr s) (stream-cdr t)))))



(1, 1)  (1, 2) (1, 3) (1, 4) ...        (1, 100)
        (2, 2) (2, 3) (2, 4)              . 
               (3, 3) (3, 4)              . 
                      (4, 4)              .
                                          .                                    
                                          .
                                        (100, 100)



前面空格由后面的流顺序插入

(pair 1 1)   (pair 2 2)    (pair 3 3)      ...     (pair 99 99)        (pair 100 100)

 (1 1)        (2 2)         (3 3)                    (99 99)              (100 100)
 (1 2)        (2 3)         (3 4)                    (99 100)
		       	          
 (1 3)        (2 4)         (3 5)                    (99 101)
              
 (1 4)        (2 5)         (3 6)
  
 (1 5)        (2 6)         (3 7)
 
 (1 6)        (2 7)         (3 8)

 (1 7)        (2 8)         (3 9)

   .
   .
   .
 (1 100)


(100 100) 分别在(pair 100 100), (pair 99 99), (pair 98 98) ... (pair 1 1) 中的排名
   1
   3 
   3+2+2 = 7
   7+2+6 = 15
   .
   .
   .

A(1) = 1
A(2) = 3

A(n+1) = A(n) + 2 + A(n) - 1 = 2 * A(n) + 1




A(100) = 2^100 - 1

所以(100 100) 在 (pair 1 1) 中排名为2^100 -1

(1 100) 排在198位












