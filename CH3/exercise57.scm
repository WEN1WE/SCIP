(define fibs (cons-stream
   0
   (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

(define (add-streams s1 s2) (stream-map + s1 s2))


    1 1 2 3 5 8       
    0 1 1 2 3 5
0 1 1 2 3 5 8 13 


; 第n个数字，大约需要n次加法



1th Fibonacci number   proc1 : (cons-stream 0 proc2)
----> (0 proc2)

2th Fibonacci number   proc2 : (cons-stream 1 (add-streams (stream-cdr fibs) fibs))
----> (1 proc3)


3th Fibonacci number  proc3 : (add-streams (stream-cdr fibs) fibs)  1 add
  s1 (1 proc3)    s2 (0 proc2)
  (stream-map + s1 s2) 
---> (1 proc4)   

4th Fibonacci number proc4: (stream-map + (proc3) (proc2))        1 add + 1 add
---> (2 proc5)

5th Fibonacci number proc5: (stream-map + (proc4) (proc3))     2 add + 1 add + 1 add
---> (3 proc6)

 由于没有记忆，每次计算的时候，就要重头开始计算

(add-number 1) = 0
(add-number 2) = 0
(add-number 3) = 1
(add-number 4) = 2
(add-number 5) = 4
(add-number 6) = 7

(add-number n - 1) + (add-number n - 2) + 1 = (add-number n)

由于这种增长与Fibonacci number 的增长类似，所以是指数增长



