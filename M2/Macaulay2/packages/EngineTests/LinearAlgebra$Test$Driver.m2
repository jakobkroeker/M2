-- -*- coding: utf-8 -*-
newPackage(
	"LinearAlgebra$Test$Driver",
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
    	Headline => "LinearAlgebra Test driver",
        DebuggingMode => false
    	)

-- rsync -av /home/agag/kroeker/Projects/M2gitNew/M2/Macaulay2/packages/EngineTests/ ./StagingArea/common/share/Macaulay2/packages/EngineTests/ --ignore-existing
-- path=append(path,"StagingArea/common/share/Macaulay2/packages/EngineTests")


needsPackage "LinearAlgebra$Test$FFPACK"
needsPackage "LinearAlgebra$Test$FLINT"
needsPackage "LinearAlgebra$Test$GF"
needsPackage "LinearAlgebra$Test$EngineGF"
needsPackage "LinearAlgebra$Test$Givaro"

check LinearAlgebra$Test$FFPACK
check LinearAlgebra$Test$FLINT
check LinearAlgebra$Test$GF
check LinearAlgebra$Test$EngineGF
check LinearAlgebra$Test$Givaro
-- check LinearAlgabra$Test$Driver


if hasFlint and hasFFPACK then 
TEST ///
  -- Which rings have linear algebra routines defined?
  debug Core
  hasLinAlgRank = (R) -> (
      M = mutableMatrix(R, 4, 4);
      fillMatrix M;
      rawLinAlgRank raw M
      );

  hasEngineLinearAlgebra(ZZ)
  assert hasEngineLinearAlgebra(ZZFlint)
  assert hasEngineLinearAlgebra(QQ)
  assert hasEngineLinearAlgebra(ZZp(101, Strategy=>"FLINT"))
  assert hasEngineLinearAlgebra(ZZp(101, Strategy=>"FFPACK"))
  hasEngineLinearAlgebra(ZZ/101)
  hasEngineLinearAlgebra (GF(2^3, Strategy=>null))
  hasEngineLinearAlgebra (GF(2^3, Strategy=>"Givaro"))
  hasEngineLinearAlgebra (GF(2^3, Strategy=>"Old"))

  hasLinAlgRank ZZ  -- NO
  hasLinAlgRank QQ  -- NO
  hasLinAlgRank (ZZp(101, Strategy=>"FLINT")) -- yes, this one works!
  hasLinAlgRank (ZZp(101, Strategy=>"FFPACK")) -- yes, this one works!
  hasLinAlgRank (ZZp(101, Strategy=>null)) -- NO

  debug Core
  initializeEngineLinearAlgebra QQ
///

