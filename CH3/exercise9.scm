
(define (factorial n)
	(if (= n 1) 1 (* n (factorial (- n 1)))))


E1  n: 6
 (* 6 (factorial 5))

E2 n: 5
 (* 5 (factorial 4))

E3 n: 4
 (* 4 (factorial 3))

E4 n: 3
 (* 3 (factorial 2))

E5 n: 2
 (* 2 (factorial 1))

E6 n: 1
 1


(define (factorial n) (fact-iter 1 1 n)) 

(define (fact-iter product counter max-count)
	(if (> counter max-count) product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))


E1 n: 6
 (fact-iter 1 1 6)

E2 product: 1 
   counter: 1 
   max-count: 6
  (fact-iter 1 2 6)

E3 product: 1
   counter: 2
   max-count: 6
  (fact-iter 2 3 6)

E4 product: 2
   counter: 3
   max-count 6
  (fact-iter 6 4 6)

E5 product: 6
   counter: 4
   max-count: 6
  (fact-iter 24 5 6)

E6 product: 24
   counter: 5
   max-count 6
  (fact-iter 120 6 6)

E7 product: 120
   counter: 6
   max-count 6
  (fact-iter 720 7 6)

E8 product: 720
   counter 7
   max-count 6
  720














