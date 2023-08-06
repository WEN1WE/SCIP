(map op x1 x2)
这里的op 是一个程序 
就是(delay-it op env)

(eval op) ===》 ('thunk op env)
不会是程序 运行错误