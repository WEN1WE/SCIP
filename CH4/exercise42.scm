Betty : (Kitty 2) (Betty 3)
Ethel : (Ethel 1) (Joan 2)
Joan : (Joan 3) (Ethel 5)
Kitty : (Kitty 2) (Mary 4)
Mary : (Mary 4) (Betty 1)



(define (liars)
	(let (
			(Betty (amb 1 2 3 4 5))
			(Ethel (amb 1 2 3 4 5))
			(Joan (amb 1 2 3 4 5))
			(Kitty (amb 1 2 3 4 5))
			(Mary (amb 1 2 3 4 5))

		 )

		(require (or (and (= Kitty 2) (not (Betty 3)))
			         (and (not (= Kitty 2)) (Betty 3))))


		(require (or (and (= Ethel 1) (not (Joan 2)))
	         		 (and (not (= Ethel 1)) (Joan 2))))

		(require (or (and (= Joan 3) (not (Ethel 5)))
     				 (and (not (= Joan 3)) (Ethel 5))))


		(require (or (and (= Kitty 2) (not (Mary 4)))
			         (and (not (= Kitty 2)) (Mary 4))))


		(require (or (and (= Mary 4) (not (Betty 1)))
			         (and (not (= Mary 4)) (Betty 1))))

		(require (distict? (list Betty Ethel Joan Kitty Mary)))

		(list (list 'Betty Betty)
			  (list 'Ethel Ethel)
			  (list 'Joan Joan)
			  (list 'Kitty Kitty)
			  (list 'Mary Mary)

		)
	)
)


