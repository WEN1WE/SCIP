(define (or-gate a1 a2 output) 
	(let ( 
			(a (make-wire))
		 	(b (make-wire))
		 	(c (make-wire))
		 )
		(inverter a1 a)
		(inverter a2 b)

		(and-gate a b c)
		(inverter c output)
	)
)

;delay为1次and delay加上 2次inverter delay




