-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$FFPACK",
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
        PackageExports => {"LinearAlgebra$Test$Base" },
    	Headline => "LinearAlgebra FFPACK Test driver",
        DebuggingMode => false
    	)


--------------------------------
-- ffpack linear algebra: ZZ/p -
--------------------------------

debug Core;

path = append( path, LinearAlgebra$Test$FFPACK#"source directory");


needsPackage "LinearAlgebra$Test$Base"
debug LinearAlgebra$Test$Base

export {
ZZpFFPACK
}

ZZpFFPACK  = ( modPrime )->
(
  assert(isPrime modPrime);
  ZZp( modPrime, Strategy=>"FFPACK")
)

if hasFFPACK then 
TEST ///
  path = append( path, LinearAlgebra$Test$FFPACK#"source directory");
  debug Core
  --needsPackage "LinearAlgebra$Test$Base"
  R = ZZpFFPACK(2 );
  testDeterminant R;
  testMult R;
  {*
  testInverse R; -- FAILS
  testRank R;  -- FAILS
  *}
///

if hasFFPACK then 
TEST ///
  path = append( path, LinearAlgebra$Test$FFPACK#"source directory");
  debug Core --required, why? otherwiese testLinearAlgebraSet is not defined.
  R = ZZpFFPACK ( 3 );
  testLinearAlgebraSet R;
///

if hasFFPACK then 
TEST ///
  path = append( path, LinearAlgebra$Test$FFPACK#"source directory");
  debug Core
  R = ZZpFFPACK( 5 );
  testLinearAlgebraSet R;
///

if hasFFPACK then 
TEST ///
  debug Core
  R = ZZpFFPACK( 101 );
  testLinearAlgebraSet  R;
///

if hasFFPACK then 
TEST ///
  debug Core
  R = ZZpFFPACK( 30000001 );
  testLinearAlgebraSet R;
///

if hasFFPACK then 
TEST ///
  debug Core
  R = ZZpFFPACK( maxFFPACKPrime )
  testLinearAlgebraSet R;
  --R = ZZp(33554467, Strategy => "FFPACK") -- this should not work
///

