(rule (lives-near ?person-1 ?person-2)
	(and (address ?person-1 (?town . ?rest-1)) 
		 (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))))



(rule (replace ?person1 ?person2)
	(and (job ?person1 ?x)
		 (job ?person2 ?y)
		 (or (same ?x ?y)
		 	(can-do-job ?x ?y)
		 )
		 (not (same ?person1 ?person2))
	)
)

(replace ?x (Cy D. Fect))


(and (replace ?person1 ?person2)
	 (salary ?person1 ?x)
	 (salary ?person2 ?y)
	 (lisp-value < ?x ?y)
	 
)