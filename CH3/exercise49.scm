例如一个程序proc
公共资源 a1 a2 a3 a4
程序先访问前面2个资源，再确定是否访问后面的资源

(proc a1 a2)
(proc a3 a4)


(proc a3 a4)
(proc a1 a2)

这样，两个程序都获得了对方的mutex，这样就造成了死锁









