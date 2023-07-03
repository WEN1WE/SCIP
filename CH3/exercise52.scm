
#|

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

f

(cons-stream ⟨a⟩ ⟨b⟩)
(cons ⟨a⟩ (delay ⟨b⟩))

(delay ⟨exp⟩)
-- (lambda () ⟨exp⟩)
-- (memo-proc (lambda () ⟨exp⟩))



(define (force delayed-object) (delayed-object))



(define (memo-proc proc)
	(let ((already-run? false) (result false))
		(lambda ()
			(if (not already-run?)
				(begin (set! result (proc)) 
					(set! already-run? true)
                 	result)
                result))))


(define temp (memo-proc proc))
(lambda () <exp>)
(delay <exp>)


(define (stream-map proc s)
	(if (stream-null? s) 
		the-empty-stream
	    (cons-stream (proc (stream-car s))
	                 (stream-map proc (stream-cdr s)))))


|#

(define (display-stream s) 
	(stream-for-each display-line s))
(define (display-line x) (newline) (display x))


(define (stream-enumerate-interval low high) 
	(if (> low high)
      the-empty-stream
      (cons-stream
      	low
       (stream-enumerate-interval (+ low 1) high))))


(define sum 0)


(define (accum x) (set! sum (+ x sum)) sum) 

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))

seq <---> (1 proc)

(define y)    sum-start = 1
i    sum     seq/new-sum
2     1       3
3     3       6
sum-end = 6
y <---> (6 proc)


(define z)    sum-start = 6
i    sum    seq/new-sum
2     6        8
3     8       11
4     11      15							
sum-end = 15
z <---> (15 proc)

(stream-ref y 7)  sum-start = 15
i    sum    seq/new-sum   y
4     15     19
5     19     24           21
6     24     30           30
7     30     37
8     37     45
9     45     54           54
10    54     64           64
11    64     75
12    75     87
13    87     100          100
14    100    114          114
15    114    129
16    129    145
17    145    162          162
sum-end 162




(display-stream z)  sum-start = 162
i     sum    seq/new-sum
5     162      167
6     167      173    
7
8
9
10
11
12
13
14
15
16
17
18
19
20





				





#|
   
(cons 1 (delay (stream-enumerate-interval 2 20)))
(cons 1 (delay (stream-map accum (cons 2 (delay (stream-enumerate-interval 3 20))))))





(define (stream-filter pred stream)
	(cond ((stream-null? stream) the-empty-stream)
	      ((pred (stream-car stream))
	       (cons-stream (stream-car stream)
	                      (stream-filter
	                       pred
	                       (stream-cdr stream))))
		  (else (stream-filter pred (stream-cdr stream)))))

|#


  

(define y (stream-filter even? seq)) 
;(cons 6 (delay (stream-map accum (cons 4 (delay (stream-enumerate-interval 5 20)))))
;(cons 6 (delay (stream-filter even? (cons 10 (delay (stream-map accum (cons 5 (delay (stream-enumerate-interval 6 20)))))))))



;(define z
	;(stream-filter (lambda (x) (= (remainder x 5) 0)) seq))


;(stream-ref y 7)
; sum 136




; (display-stream z)


#|

流的定义，是（1 proc1）这个程序有一个外部的变量，保存程序是否执行，程序的result
proc1 为 (delay <exp>) 求得

(proc1)

得到 (2 proc2)


|#








