newPackage(
        "CustomEngineTests",
    	AuxiliaryFiles => false,
        Version => "0.1", 
        Date => "29 Aug 2011",
	    Authors => {
            {Name => "Michael E. Stillman", 
		        Email => "mike@math.cornell.edu", 
		        HomePage => "http://www.math.cornell.edu/People/Faculty/stillman.html"},
	        {Name => "Jakob Kroeker", 
		        Email => "Jakob Kröker <kroeker@math.uni-hannover.de>", 
		        HomePage => "" }
            },
        Headline => "a sandbox test suite for the Macaulay2 engine ",
	    PackageExports => {"FastLinearAlgebra"},
        DebuggingMode => true
        )



load "EngineTests/LinearAlgebra$Test$Base.m2"
load "EngineTests/LinearAlgebra$Test$EngineGF.m2"

--load "EngineTests/LinearAlgebra$Test$Givaro.m2" --ok
--load "EngineTests/LinearAlgebra$Test$FFPACK.m2" --fails
--load "EngineTests/LinearAlgebra$Test$FLINT.m2"  --fails
--load "EngineTests/LinearAlgebra$Test$ZZp.m2"    

--load "EngineTests/MutableMatrix$Test$Driver.m2"

--load "EngineTests/LinearAlgebra$Test$ZZp.m2"

--load "EngineTests/LinearAlgebra$Test$FLINT.m2"

--load "EngineTests/LinearAlgebra$Test$FFPACK.m2"

