(and (supervisor ?person (Bitdiddle Ben))
	 (address ?person ?where))


 (and (salary (Bitdiddle Ben) ?number) 
              (salary ?person ?amount) 
              (lisp-value < ?amount ?number)) 


 
 (and (supervisor ?person ?boss) 
               (not (job ?boss (computer . ?type))) 
               (job ?boss ?job)