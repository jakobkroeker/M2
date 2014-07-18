-- Bugs in char series
-- There are two bugs here, both currently the same 
-- We keep them both here, because one possible fix 
-- will only fix the first of the two.  So it is best to keep
-- both examples.
-- (see email to Hans Schoenemann, 24 Sep 2013)
S = QQ[x,v_3, v_2, v_1, MonomialOrder=>Lex]
f = v_1^2+v_1+1
g = v_2^2+v_1*v_2+13
h = (v_3-v_1-v_2)*(v_3-v_2) % ideal(f,g)
I = ideal(f,g,h)
I;
debug Core
comps = {ideal(v_1^2+v_1+1,v_2^2+v_2*v_1+13,v_3-v_2), ideal(v_1^2+v_1+1,v_2^2+v_2*v_1+13,v_3-v_2-v_1)}
assert(intersect comps == I)
csI = rawCharSeries raw gens I
mpI = minimalPrimes I
assert (# decompose I == 2)
dI = decompose I                                                                                

-- Bug #2 (actually, found before the one above).
debug Core
R = QQ[x,r,b,u, MonomialOrder=>Lex] -- any of these rings gives the wrong answer.
I = ideal(b^3-6*b^2+5*b-1,r^2-r*u+u^2*b+b^2-6*b+1,x^2+2*x*r*b^2-11*x*r*b+5*x*r+r*u-u^2*b)
comps = {ideal(b^3-6*b^2+5*b-1,r^2-r*u+b^2+b*u^2-6*b+1,x+b^2*u-5*b*u+2*u), ideal(b^3-6*b^2+5*b-1,r^2-r*u+b^2+b*u^2-6*b+1,x+2*r*b^2-11*r*b+5*r-b^2*u+5*b*u-2*u)}
intersect comps == I
rawCharSeries raw gens I -- only one.
mpI = minimalPrimes I
C1 = decompose I
C1 = C1/(c -> ideal gens gb c)
assert(#C1 == 2)


LIB("primdec.lib");
ring rng = 0,(x,v_3,v_2,v_1),lp;
 
ideal I = v_1^2+v_1+1,v_2^2+v_2*v_1+13,v_3^2-2*v_3*v_2-v_3*v_1-13;

def L1 = primdecGTZ(I);
ASSUME(0, testPrimary(L1,I) );
list LGTZI = minAssGTZ(I);
list LCharI = minAssChar(I);
LGTZI;
LCharI;

ASSUME(0, size(LGTZI)==size(LCharI) );

LIB("primdec.lib");
ring rng = 0,(x,r,b,u),lp;
ideal I = b^3-6*b^2+5*b-1,r^2-r*u+u^2*b+b^2-6*b+1,x^2+2*x*r*b^2-11*x*r*b+5*x*r+r*u-u^2*b;
def L1 = primdecGTZ(I);
ASSUME(0, testPrimary(L1,I) );
list LGTZI = minAssGTZ(I);
list LCharI = minAssChar(I);
LGTZI;
LCharI;

ASSUME(0, size(LGTZI)==size(LCharI) );

char_series(I);

