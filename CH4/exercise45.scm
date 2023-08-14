(define nouns '(noun student professor cat class)) 
(define verbs '(verb studies lectures eats sleeps)) 
(define articles '(article the a))
(define prepositions '(prep for to in by with))


#|
(sentence (noun-phrase (article the) (noun cat))
          (verb eats))



(define (parse-sentence) (list 'sentence
         (parse-noun-phrase)
         (parse-word verbs)))



; the cat 
(define (parse-noun-phrase) 
	(list 'noun-phrase
        (parse-word articles)
        (parse-word nouns)))
|#

(define (parse-word word-list)
	(require (not (null? *unparsed*)))
	(require (memq (car *unparsed*) (cdr word-list))) 
	(let ((found-word (car *unparsed*)))
		(set! *unparsed* (cdr *unparsed*)) 
		(list (car word-list) found-word)))





; for the cat
(define (parse-prepositional-phrase) 
	(list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))



(define (parse-sentence)
	(list 'sentence (parse-noun-phrase) (parse-verb-phrase)))


; look for   play with
; 动词短语
(define (parse-verb-phrase)
	(define (maybe-extend verb-phrase)
	    (amb verb-phrase
	    	(maybe-extend
	          (list 'verb-phrase
					verb-phrase
	                (parse-prepositional-phrase)))))
	(maybe-extend (parse-word verbs)))


; a cat in the class.
; 简单名词短语
(define (parse-simple-noun-phrase) 
	(list 'simple-noun-phrase
        (parse-word articles)
		(parse-word nouns))) 

; 名词短语
(define (parse-noun-phrase)
	(define (maybe-extend noun-phrase) 
		(amb noun-phrase
         	(maybe-extend
         	(list 'noun-phrase
				noun-phrase
                (parse-prepositional-phrase)))))
  	(maybe-extend (parse-simple-noun-phrase)))


(define *unparsed* '()) 

(define (parse input)
	(set! *unparsed* input)
	(let ((sent (parse-sentence)))
		(require (null? *unparsed*)) 
		sent))



(parse '(the student with the cat sleeps in the class))


(sentence
 (noun-phrase
  (simple-noun-phrase (article the) (noun student))
  (prep-phrase
   (prep with)
   (simple-noun-phrase (article the) (noun cat))))

 (verb-phrase
  (verb sleeps)
  (prep-phrase
   (prep in)
   (simple-noun-phrase (article the) (noun class)))))





(parse '(the professor lectures to the student with the cat))


(sentence
 (simple-noun-phrase (article the) (noun professor))
 (verb-phrase

  (verb-phrase
   (verb lectures)
   (prep-phrase
	(prep to)
    (simple-noun-phrase (article the) (noun student))))

  (prep-phrase
   (prep with)
   (simple-noun-phrase (article the) (noun cat)))))



(sentence
 (simple-noun-phrase (article the) (noun professor))
 (verb-phrase
  (verb lectures)
  
  (prep-phrase
	(prep to)
	(noun-phrase
	 (simple-noun-phrase (article the) (noun student))
	 (prep-phrase
	  (prep with)
	  (simple-noun-phrase (article the) (noun cat)))))))





(The professor lectures to the student (in the class) (with the cat))

(The professor lectures to (the student (in the class) (with the cat)))

(The professor lectures to (the student in the class) (with the cat))

(The professor lectures to (the student (in the class (with the cat))))

(The professor lectures to the student ((in the class (with the cat)))



(The professor)
(simple-noun-phrase (article the) (noun professor))


(verb lectures)

(prep to)

(the student)
(simple-noun-phrase (article the) (noun student))


(with the cat)
(prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat))))

(in the class)
(prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))



(sentence
	(simple-noun-phrase (article the) (noun professor))

	(verb-phrase






)









