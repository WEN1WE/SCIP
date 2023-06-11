

division1

division2 

    personnel records : key --->  employees’ names   
                        information --->  address and salary.

       




(define (find-employee-record )

)



(define (lookup given-key set-of-records) 
	(cond ((null? set-of-records) false)
          ((equal? given-key (key (car set-of-records)))
          	(car set-of-records))
          (else (lookup given-key (cdr set-of-records)))))


(define (install-division1-package)
	(define (lookup given-key set-of-records)
	)

	(define (salary record)

	)

	(define (address record)

	)



	(put 'lookup 'division1 lookup)
	(put 'salary 'division1 salary)
	(put 'address 'division1 address)
)

(define (type-tag division)
)

(define (contents division)
) 


(define (get-record employee division)
	((get (type-tag division) 'lookup) employee (contents division))
)

(define (get-salary division record)
	((get (type-tag division) 'salary) record)
)

(define (find-employee-record employee divisions)
	(if (null? divisions)
		false
		(or (get-record employee (car divisions)) (find-employee-record employee (cdr divisions))) 
	)
)



                  division1            division2            division3
              -----------------------------------------------------------
   lookup    |    
   salary    |
   address   |
             |
             |
             |
             |