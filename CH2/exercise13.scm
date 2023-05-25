(make-center-percent c1 p1)
(c1 * (1 - p1), c1 * (1 + p))

(make-center-percent c2 p2)
(c2 * (1 - p2), c2 * (1 + p2))

product interval
(c1 * c2 * (1 - p1 - p2 + p1 * p2), c1 * c2 * (1 + p1 + p2 + p1 * p2))

由于p1 p2 比较小， p1 * p2可以忽略

所以区间为

(c1 * c2 * (1 - p1 - p2), c1 * c2 * (1 + p1 + p2))
所以误差就为(p1 + p2)
