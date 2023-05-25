x: (a b) y: (c d)  
(1 2) (3 5)
x: (-a -b) y:(-c -d)  
(-1 -2) (-3 -5)
(* (lower-bound x) (lower-bound y))   ll uu
(* (upper-bound x) (upper-bound y))

一个为负
x: (-a b) y: (c d)
(-1 2) (3 5)
x: (a -b) y: (c d)
(1 -2) (3 5)
(* (lower-bound x) (upper-bound y))   lu uu
(* (upper-bound x) (upper-bound y))

x: (a b) y: (-c d)
(1 2) (-3 5)
x: (a b) y: (c -d)
(1 2) (3 -5)
(* (upper-bound x) (lower-bound y))   ul uu
(* (upper-bound x) (upper-bound y))

三个为负
x: (-a -b) y: (-c d)
(-1 -2) (-3 5)
x: (-a -b) y: (c -d)
(-1 -2) (3 -5)
(* (lower-bound x) (upper-bound y))   lu ll
(* (lower-bound x) (lower-bound y))

x: (-a b) y: (-c -d)
(-1 2) (-3 -5)
x: (a -b) y: (-c -d)
(1 -2) (-3 -5)
(* (upper-bound x) (lower-bound y))   ul ll
(* (lower-bound x) (lower-bound y))


两个为负
x: (-a -b) y: (c d)
(-1 -2) (3 5)
x: (a b) y: (-c -d)
(1 2) (-3 -5)
(* (lower-bound x) (upper-bound y))  lu ul
(* (upper-bound x) (lower-bound y))


这里的情况比较复杂，没有能想明白
x: (-a b) y: (-c d)
(-1 2) (-3 5)
x: (a b) y: (c d)
(1 2) (3 5)
(* (lower-bound x) (upper-bound y))  lu ul
(* (upper-bound x) (lower-bound y))


