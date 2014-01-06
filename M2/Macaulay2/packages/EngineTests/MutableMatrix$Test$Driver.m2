-- -*- coding: utf-8 -*-
newPackage(
	"MutableMatrix$Test$Driver",
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
    	Headline => "MutableMatrix Test Driver",
        DebuggingMode => false
    	)

needsPackage "MutableMatrix$Test$Elementary"
check MutableMatrix$Test$Elementary

needsPackage "MutableMatrix$Test$ReduceByPivots"
check "MutableMatrix$Test$ReduceByPivots"


end

--
restart
needsPackage "MutableMatrix$Test$Elementary"
check MutableMatrix$Test$Elementary

testMutableMatrices(ZZ/101)

-- BUG!! in usual Matrix submatrix code!!
R = ZZ/101
m = matrix mutableMatrix(map(R^5,R^6, (i,j) -> 100*i+j), Dense=>true);
m^{1,1}
----------------------
R = ZZp 101
     m = mutableMatrix(map(R^5,R^6, (i,j) -> 100*i+j), Dense=>true);
     assert(2*m == m+m);
     assert(3*m == m+m+m);
     m = mutableMatrix(map(R^5,R^6, (i,j) -> 100*i+j), Dense=>false);
     assert(2*m == m+m);
     assert(3*m == m+m+m);

debug Core
rawSubmatrix(raw m, {0,1,2,3,4},{0,1,2,3,4})
m = mutableMatrix(map(R^3,R^20, (i,j) -> 100*i+j), Dense=>true)
rawSubmatrix(raw m, {0,2,0,2},{0,2,5,7,11,30})
rawSubmatrix(raw m, {0,2,3,2},{0,2,5,7,11,10})

debug EngineTests
testMutableMatrices(ZZ/101)
testMutableMatrices(ZZ/2)
testMutableMatrices(GF 4)

(67108819, 67108837, 67108859, 67108879, 67108913, 67108919, 67108933, 67108957, 67108961, 67108981)

kk = ZZp 67108819
testMutableMatrices kk

kk = ZZp 67108981

kk = ZZp 32003
testMutableMatrices kk

kk = ZZp 1049599
kk = ZZp 1073742851

-- Question: how do we get 
--kk = GF (1073742851, 1, Strategy=>"Givaro")
--testMutableMatrices kk

--kk = GF (1049599, 1, Strategy=>"CompleteGivaro")
--testMutableMatrices kk

kk = GF(2,4,Strategy=>"Old")
testMutableMatrices kk -- fails, since rank is not yet defined for this type of ring

kk = GF(2,4,Strategy=>"Givaro")
testMutableMatrices kk

kk = GF(2,4,Strategy=>"CompleteGivaro")
testMutableMatrices kk

kk = GF(2,12,Strategy=>"New")
testMutableMatrices kk

kk = GF(5,12,Strategy=>"New")
testMutableMatrices kk

