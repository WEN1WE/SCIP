

(rule (outranked-by ?staff-person ?boss) 
	(or (supervisor ?staff-person ?boss)
		(and (supervisor ?staff-person ?middle-manager) 
			 (outranked-by ?middle-manager ?boss))))





(rule (outranked-by ?staff-person ?boss) 
	(or (supervisor ?staff-person ?boss)
		(and (outranked-by ?middle-manager ?boss) 
			 (supervisor ?staff-person ?middle-manager))))



(outranked-by (Bitdiddle Ben) ?who)

(outranked-by ?middle-manager ?who) 