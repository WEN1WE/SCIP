(define (filtered-accumulate combiner null-value filter term a next b)
	(if (> a b)
		null-value
		(if (filter a)
			(combiner (term a) (filtered-accumulate combiner null-value filter term (next a) next b))
			(filtered-accumulate combiner null-value filter term (next a) next b)

		)
	)
)

(define (sum-of-prime term a next b)
	(filtered-accumulate + 0 prime? term a next b)
)

(define (product-integer term a next b)
	(define (filter x)
		(= 1 (gcd x b))
	)
	(filtered-accumulate * 1 filter term a next b) 
)

(define (inc n) (+ n 1))
(define (f x) x)


(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
(else (find-divisor n (+ test-divisor 1))))) (define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
(= n (smallest-divisor n)))


(define (gcd a b) (if (= b 0)
      a
      (gcd b (remainder a b))))