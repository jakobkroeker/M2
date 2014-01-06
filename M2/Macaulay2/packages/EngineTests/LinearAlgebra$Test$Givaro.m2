-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$Givaro",
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
    	Headline => "LinearAlgebra Givaro Test  ",
        DebuggingMode => false
    	)

needsPackage "LinearAlgebra$Test$Base"

--------------------------------
-- Givaro GF -------------------
--------------------------------
if hasFFPACK then
TEST ///
  debug Core
  R = GF(3,2, Strategy=>"Givaro")
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;  
///

if hasFFPACK then
TEST ///
  debug Core
  R = GF(5,12)
  testDeterminant R
  testMult R
  testNullspace R;
  testRank R;
  testInverse R;  
///



