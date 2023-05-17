(define 
	(cube x) 
	(* x x x)
)

(define
	(p x)
	(- (* 3 x) (* 4 (cube x)))
)

(define 
	(sine angle)
	(if (not (> (abs angle) 0.1))
		angle
		(p (sine (/ angle 3.0)))
	)
)


#|
(sine 12.15)
(p (sine 4.05))
(p (p (sine 1.35)))
(p (p (p (sine 0.45))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine 0.05))))))    可以看出，一共执行了5次


可以看出空间需要logn
时间需要logn
|#