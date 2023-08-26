    (rule (end-in-grandson (grandson)))
    (rule (end-in-grandson (?x . ?rest))
          (end-in-grandson ?rest))



    (rule ((great grandson) ?x ?y)
        (and (son ?x ?z)
            (grandson ?z ?y)))
    (rule ((great . ?rel) ?x ?y)
        (and (son ?x ?z)
            (?rel ?z ?y)
            (end-in-grandson ?rel)))
    