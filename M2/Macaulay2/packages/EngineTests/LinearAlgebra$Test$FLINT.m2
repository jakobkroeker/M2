-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$FLINT",
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
    	Headline => "LinearAlgebra FLINT Test driver",
        DebuggingMode => false
    	)
--------------------------------
-- flint linear algebra: ZZ/p --
--------------------------------



needsPackage "LinearAlgebra$Test$Base"

ZZpFlint = (char) ->
{
   ZZp(char, Strategy => "FLINT")
}

testLinearAlgebraSet = (rng)->
{
  debug Core

  testDeterminant rng;
  testMult        rng;
  testInverse     rng;
  testRank        rng;
  testNullspace   rng;
  --testSolve       rng;
}

  -- Not written yet: nullSpace for left side
  -- solveLinear: somehow the wrong one is being called
  -- rankProfile
  -- LUdecomposition
if hasFlint then 
TEST ///
  debug Core
  R = ZZp(2, Strategy => "FLINT")
  testDeterminant R
  testMult R
  testNullspace R;   -- the fillMatrix is not working here...
  testRank R;
  
 -- testSolve R  -- calling wrong rawLinAlgSolve: not implemented!

///

if hasFlint then 
TEST ///
  R = ZZpFlint( 3 )
  testLinearAlgebraSet R
///

if hasFlint then 
TEST ///
  R = ZZpFlint( 5 )
  testLinearAlgebraSet R
///

if hasFlint then 
TEST ///
  R = ZZpFlint( 101 )
  testLinearAlgebraSet R
///

if hasFlint then 
TEST ///
  -- largest prime < 2^62
  R = ZZpFlint( 4611686018427387847 ) 
  testLinearAlgebraSet R
///

if hasFlint then 
TEST ///
  -- largest prime < 2^63
  R = ZZpFlint(9223372036854775783 )
  testLinearAlgebraSet R
///


if hasFlint then 
TEST ///
  R = ZZpFlint(maxFLINTPrime)
  testLinearAlgebraSet R
///

if hasFlint then 
TEST ///
  -- Most of this code is designed for fields...
  R = ZZFlint
  testDeterminant R
  testMult R
///

if hasFlint then 
TEST ///
  -- Flint QQ
  R = QQFlint
  testDeterminant R
  testMult R
  testRank R
  testNullspace R;
///


