(meeting accounting (Monday 9am))
(meeting administration (Monday 10am))
(meeting computer (Wednesday 3pm))
(meeting administration (Friday 1pm))
(meeting whole-company (Wednesday 4pm))







(meeting ?x (Friday ?y))





(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
          (and (job ?person (?division . ?type))
               (meeting ?division ?day-and-time))))



(meeting-time (Hacker Alyssa P) (Wednesday ?time))