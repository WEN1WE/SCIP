(rule (lives-near ?person-1 ?person-2)
	(and (address ?person-1 (?town . ?rest-1)) 
		 (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))))


(rule (bigshot ?person ?division) 
        (and (job ?person (?division . ?rest)) 
             (or (not (supervisor ?person ?boss)) 
                 (and (supervisor ?person ?boss) 
                      (not (job ?boss (?division . ?r)))))))