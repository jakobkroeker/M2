-- -*- coding: utf-8 -*-
newPackage(
	"Ring$Test$Driver",
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
    	Headline => "Ring Test Driver",
        DebuggingMode => false
    	)

needsPackage "Ring$Test$Promote"

check Ring.Test.Promote
