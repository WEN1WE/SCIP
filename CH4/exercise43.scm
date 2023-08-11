Mr. Moore   :   Lorna

Colonel Downing  : Melissa (Sir Barnacle’s daughter)

Mr. Hall  :  Rosalind

Sir Barnacle Hood  :   Gabrielle

(Gabrielle’s father) : (Dr. Parker’s daughter)
Hall 


Lorna 1                Mr. Moore 
Melissa 2             Colonel Downing
Rosalind 3             Mr. Hall
Gabrielle 4           Sir Barnacle Hood
Mary Ann Moore 5       Dr. Parker



(define (daughter)
	(let (
			(Moore (amb 5))
			(Barnacle (amb 2))
			(Colonel (amb 1 3 4))

			(let ((Hall (amb 1 4)))
				(require? (not (= Colonel Hall)))
				(let ((Parker (amb 1 3 4)))
					(require? (and (not (= Parker Colonel) (not (= Parker Hall)))))
					(require? (or (and (= Colonel 4) (= Parker 2)) (and (= Hall 4) (= Parker 3))))
				)
			)
		 )
	)
)