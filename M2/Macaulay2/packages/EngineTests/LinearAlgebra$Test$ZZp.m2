-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$ZZp",
	AuxiliaryFiles => false,
    	Version => "0.1",
    	Date => "January 3, 2013",
	Authors => {
	     {Name => "Michael E. Stillman", 
		  Email => "mike@math.cornell.edu", 
		  HomePage => "http://www.math.cornell.edu/People/Faculty/stillman.html"},
	     {Name => "Jakob Kroeker", 
		  Email => "Jakob Kröker <kroeker@uni-math.gwdg.de>", 
		  HomePage => "" }
	     },
    	Headline => "LinearAlgebra ZZp Test driver",
        DebuggingMode => false
    	)
--------------------------------
-- engine ZZ/p -----------------
--------------------------------
TEST ///
  debug Core
  R = ZZp(2)
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
///

TEST ///
  debug Core
  R = ZZp 3
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;
///

TEST ///
  debug Core
  R = ZZp 101
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;
///

TEST ///
  debug Core
  R = ZZp 32749
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;
///


---------------------------------
-- linear algebra: engine ZZ/p --
---------------------------------
TEST ///
  debug Core
  R = ZZ/101
  M = mutableMatrix matrix(R, {{0,3,2,1,4,7},{0,0,4,3,7,2},{0,0,0,1,7,4},{0,0,0,0,0,3}})
  b = transpose mutableMatrix matrix(R, {{11,9,11,3}})
  LUdecomposition M
  assert(rank M == 4)
  assert(rawLinAlgRankProfile(raw M, false) == {1,2,3,5})
  L = solve(M, b)
  assert(M*L - b  == 0)
  N = nullSpace M 
  assert(M * N == 0)

  L = mutableMatrix(R,4,4)
  fillMatrix L
  M1 = L*M
  b1 = L*b
  
  rank M1
  (P,L,U) = LUdecomposition M1
  assert(L*U == M1)

  rawLinAlgRankProfile(raw M1, false) == {1,2,3,5}
  M1 * solve(M1,b1) == b1
  M1 * nullSpace M1 == 0
  
  M = mutableMatrix matrix(R, {{1,2,3},{1,4,6},{4,1,2}})
  det M
  id3 = mutableIdentity(R,3)
  assert(M * solve(M,id3) == id3)
  assert(solve(M,id3) * M == id3)

  assert(M * inverse M == id3)
  assert((inverse M) * M == id3)
///

TEST ///
  debug Core
  R = ZZ/101
  testLinearAlgebra R;
///


