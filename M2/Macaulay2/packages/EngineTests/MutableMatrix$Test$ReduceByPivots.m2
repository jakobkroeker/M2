-- -*- coding: utf-8 -*-
newPackage(
	"MutableMatrix$Test$ReduceByPivots",
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
    	Headline => "MutableMatrix  ReduceByPivots Test",
        DebuggingMode => false
    	)
--------------------------
-- reduceByPivots tests --
--------------------------
TEST ///
  debug Core
  -- simple tests for ZZ/101
  R = ZZ/101
  m = mutableMatrix matrix(R, {{1,2,2},{-1,1,1},{1,1,1}})
  rawReduceByPivots raw m
  m
  m = mutableMatrix(R, 15, 10)
  fillMatrix m
  rawReduceByPivots raw m
  m
  -- now try it for ZZ
  R = ZZ
  m = mutableMatrix matrix(R, {{1,2,2},{-1,1,1},{1,1,1}})
  rawReduceByPivots raw m -- CRASH
  -- QQ
  R = QQ
  m = mutableMatrix matrix(R, {{1,2,2},{-1,1,1},{1,1,1}})
  rawReduceByPivots raw m -- CRASH

  -- poly ring:
  R = ZZ/101[a..d]
  I = ideal(a^2-1, a*b*c-a-1, a*d-b*c-1, b^2-a*c)
  m1 = syz gens I
  m2 = syz m1  
  m3 = syz m2
  m4 = syz m3
  n3 = mutableMatrix m3
  n4 = mutableMatrix m4
  rawReduceByPivots raw n4
  rawReduceByPivots raw n3
///
