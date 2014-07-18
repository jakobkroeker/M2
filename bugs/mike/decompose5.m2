-- Test, coming from bugs/mike/00-bug-radical
-- That one seems to be fixed, but this part of it is failing 
-- still (25 Sep 2013).

errorDepth=0
debug Core
Istring = "ideal((v2-1)*(v3-1),
  (v4+1)*(v7+1),
  (v2-1)*(v5-1)*(v6+1),
  (v2+1)*(v6+1)*(v7-1),
  (v1-1)*(v5-1)*(v7+v4),
  v7*v6*v1+v7*v6+v7*v2*v1+v7*v2+2*v6*v4-v6*v1+v6-v4*v3*v1+v4*v3+2*v4*v2-v4*v1+v4-v3*v1+v3-v2*v1+v2-v1+1,
  (v1-1)*(v3+v2)*(v4+1),
  (v1+1)*(v3-1)*(v5-1)*(v6+1),
  (v1-1)*(v3+1)*(v4+1)*(v6+1),
  (v1-1)*(v3+1)*(v4+1)*(v5-1),
  (v1-1)*(v2-1)*(v5-1)*(v7-1))"
R1 = QQ[v7,v6,v5,v4,v3,v2,v1, MonomialOrder=>Lex]
I1 = value Istring

-- this was created using 'minprimes' in 'PD' package.
comps = {ideal(v1-1,v2-1,v4+1,v6+1), ideal(v1-1,v2-1,v6+1,v7+1), ideal(v1+1,v2-1,v4+1,v7-1), ideal(v2-1,v3-1,v4+1,v7-1), ideal(v2-1,v4+1,v5-1,v6+1),
      ideal(v2-1,v4+1,v5-1,v7-1), ideal(v2-1,v4+1,v6+1,v7-1), ideal(v3-1,v4+1,v5-1,v7-1), ideal(v3-1,v4+1,v6+1,v7-1), ideal(v1-1,v3-1,v4-1,v6+1,v7+1),
      ideal(v1+1,v2+1,v3-1,v4+1,v5-1), ideal(v1+1,v3-1,v4+1,v5-1,v6+1), ideal(v2-1,v3+1,v4-1,v6+1,v7+1), ideal(v2-1,v3+1,v5-1,v6+1,v7+1),
      ideal(v2+1,v3-1,v4+1,v5-1,v6-1), ideal(v1-1,v2+1,v3-1,v4-1,v5-1,v7+1), ideal(v1-1,v2+1,v3-1,v5-1,v6-1,v7+1), ideal(v1+1,v2+1,v3-1,v5-1,v6+1,v7+1),
      ideal(v2+1,v3-1,v4-1,v5-1,v6+1,v7+1)}
assert(intersect comps == I1)
comps/codim//tally -- 9 have codim 4, 6 have codim 5 and 4 have codim 6.

C1 = rawCharSeries raw gens I1
C1a = C1/(m -> ideal flatten entries map(R1,m))
assert(intersect C1a == I1) -- fails, so: the rawCharSeries ? or intersect! is WRONG!

C2 = decompose I1
assert(intersect C2 == I1) -- if fails,  decompose is WRONG! 

-- This is how they differ, on 25 Sep 2013:
D1 = comps/(c -> flatten entries gens gb c)//set
D2 = C2/(c -> flatten entries gens gb c)//set
D1a = C1a/(c -> flatten entries gens gb c)//set
D1 - D1a -- has 6 components missing from 'decompose'

D1 - D2 -- had 3 components missing from 'decompose', ok now
  -- was: set {{v1 + 1, v2 - 1, v4 + 1, v7 - 1}, {v2 - 1, v3 - 1, v4 + 1, v7 - 1}, {v2 - 1, v4 + 1, v5 - 1, v7 - 1}}
assert(#(D1 - D2)==0)
D2 - D1 -- ok now
  --  was:  set {{v1+1, v2-1, v3+1, v4+1, v7-1}, {v1-1, v2-1, v3-1, v4+1, v7-1}, {v1-1, v2-1, v4+1, v5-1, v7-1}, {v2-1, v3+1, v4+1, v5-1, v7-1}}
assert(#(D2 - D1)==0)

#comps -- 19 components is correct
assert(19==#C1) -- wrong
assert(19==#C1a) -- wrong
assert(19==#C2) -- ok now

