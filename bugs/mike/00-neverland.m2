--kk = ZZ/32003 -- this one just goes off into never never land, doesn't return
kk = QQ -- this one crashes very early
R = kk[x1,x2,x3,x4,x5,x6, MonomialOrder=>Lex] -- crashes with this ring and QQ
I = ideal(x1^2*x2^2*x5^8*x6^8-x3^4*x4^4,x2^8*x3^2*x4^8*x5^2-x1^4*x6^4,x1^8*x3^8*x4^2*x6^2-x2^4*x5^4)
debug Core
m = gens I
rawCharSeries raw m
