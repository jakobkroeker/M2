-- -*- coding: utf-8 -*-

-- rsync -av /home/agag/kroeker/Projects/M2gitNew/M2/Macaulay2/packages/EngineTests/ ./StagingArea/common/share/Macaulay2/packages/EngineTests/ --ignore-existing
-- path=append(path,"StagingArea/common/share/Macaulay2/packages/EngineTests")

load "LinearAlgebra$Test$Base.m2"
load "LinearAlgebra$Test$FFPACK.m2"
load "LinearAlgebra$Test$FLINT.m2"
load "LinearAlgebra$Test$ZZp.m2"
load "LinearAlgebra$Test$EngineGF.m2"
load "LinearAlgebra$Test$Givaro.m2"



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

