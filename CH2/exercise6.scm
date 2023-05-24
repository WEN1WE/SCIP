((zero f) x)
((lambda (x) x) x)
x

((zero f) x)
x


(((add-1 n) f) x)
((lambda (x) (f ((n f) x))) x)
(f ((n f) x))

(((add-1 zero) f) x)
(f x)

(define one (add-1 zero))
((one f) x)
(f x)


(define two (add-1 one))
(((add-1 one) f) x)
(f ((one f) x))
(f (f x))


(define (+ a b)
	(lambda (f) (lambda (x) (b f) ((a f) x)))
)


