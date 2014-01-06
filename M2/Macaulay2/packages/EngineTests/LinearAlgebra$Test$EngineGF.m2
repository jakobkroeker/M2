-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$EngineGF",
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
    	Headline => "LinearAlgebra EngineGF Test  ",
        DebuggingMode => false
    	)

needsPackage "LinearAlgebra$Test$Base"

--------------------------------
-- Engine GF -------------------
--------------------------------
TEST ///
  debug Core
  R = GF(3,2)
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;  
///

TEST ///
  debug Core
  R = GF(5,12)
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;  
///
