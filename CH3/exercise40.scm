
(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
				  (lambda () (set! x (* x x x))))


get11 get12 set1



get21 get22 get23 set2


set1 first
100


10 10 10    1000
10 10 100   10000
10 100 100  100000
100 100 100 1000000   remain

set2 first
1000

10 10       100
10 1000     10000
1000 1000   1000000  remain




