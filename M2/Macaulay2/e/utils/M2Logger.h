

/** @jakob:
 *   setPriority(-1) should work in a way, that the log statements do not cost anything ?
 *    
 *  re: completely removing costs is not possible without recompiling
 * 
  * **/


#include <iostream>
#include <cstdio>
#include <string>
 
#include <sstream>
#include <stdint.h>
#include <assert.h>
#include <iterator>     // std::ostream_iterator
#include <vector>       // std::vector
#include <algorithm>

#include "stackDepth.h"

class M2Logger;
class CallLogger;

#ifndef NO_LOG

template <class DerivedLogger>
class M2LoggerT
{
    friend class M2Logger;
    friend class CallLogger;
    
    public:

        const int minPriority = 0;
        const int maxPriority = 5;
        
      //  TRACE < DEBUG < INFO < WARN < ERROR < FATAL


       const int FATAL = 5;
       const int ERROR = 4;
       const int WARN = 3;
       const int INFO = 2;
       const int DEBUG = 1;
       const int TRACE = 0;
       


        static DerivedLogger& get()
        {
            static DerivedLogger    instance; // Guaranteed to be destroyed.                           // Instantiated on first use.
            return instance;
        }
        
        static  int priority( );
        static bool useStackDepth();
        static bool hasMessage( const std::string & msg ) ;
                
        static void useStackDepth( bool yn )  ;
        static void setMinPriority  ( int newPriority );   

        static void log( int priority, const std::string& message );
        static void info(   const std::string& message );
        static void warn(  const std::string& message );
        static void error(   const std::string& message );
        static void debug(   const std::string& message );
           
        static void save(std::string filename);
        static void print() ;
           
        bool iHasMessage( const   std::string   & msg );
                
        void iLog( int priority, const std::string& message );
        void iSave(std::string filename);

        void iPrint( ) ;
        
        std::string name() const
        {
            return name_m;
        }

    
    protected:
       // static thread_local int callDepth_m;
        
        bool bUseStackDepth_m;
        
        std::ostream*           osp_m;
            
        int                     priority_m; // sould be enum? // todo: not threadsafe!
        const std::string       name_m;

        std::vector< std::string>       logs_m;

 
    
        M2LoggerT() : M2LoggerT("M2LoggerT")    { }; 
        
  
    private:
         M2LoggerT(std::string name) :  osp_m ( &std::cout ),
                                        name_m(name),
                                        bUseStackDepth_m(false),
                                        priority_m(3)
        { };   
        
   /// the constructor design is explained at 
   // http://bytes.com/topic/c/answers/481312-private-constructors
    
    private:
        M2LoggerT(M2LoggerT const&);       // Don't Implement
        void operator=(M2LoggerT const&); // Don't implement
};


#include "M2Logger.hpp"

#else

  template <class DerivedLogger>
  class M2LoggerT {
      
    friend class M2Logger;
    friend class CallLogger; // bad design; can we do better? ...
    
      public:
	static inline int priority( ) {};
        static inline bool useStackDepth() {};
        static inline bool hasMessage( const std::string & msg ) {};
                
        static inline void useStackDepth( bool yn )  {};
        static inline void setPriority  ( int newPriority ) {};

        static inline void log( int priority, const std::string& message ){}; 
        static inline void info(   const std::string& message ) {};
        static inline void warn(  const std::string& message ) {};
        static inline void error(   const std::string& message ) {};
        static inline void debug(   const std::string& message ) {};
           
        static inline void save(std::string filename) {};
        static inline void print()  {};
           
        inline bool  iHasMessage( const   std::string   & msg ) {};
                
        inline void iLog( int priority, const std::string& message ) {};
        inline void iSave(std::string filename) {};

        inline void iPrint( ) {};
        
        std::string name() const
        {
            return std::string("empty logger");
        }
        
      
        
         protected:
     
            // M2LoggerT() : M2LoggerT("empty logger")    { }; 
            M2LoggerT()   { }; 
	    
  private:
	    M2LoggerT(std::string name)  
        { };   
  private:
         M2LoggerT(M2LoggerT const&);       // Don't Implement
        void operator=(M2LoggerT const&); // Don't implement
  };
#endif //NO_LOG
  

        
#define M2log M2Logger::log 

//Derive:

class M2Logger : public M2LoggerT<M2Logger>
{  
    
protected:
    // const std::string name_m;
    //    M2Logger() : name_m("M2Logger") {}
    
    // M2Logger() : M2LoggerT("M2Logger") {}
    M2Logger() : M2LoggerT() {}
     
       
    friend class M2LoggerT;
};


class CallLogger : public M2LoggerT<CallLogger>
{  
protected:
       // const std::string name_m;
       // CallLogger() : name_m("CallLogger") {}
     
    CallLogger() : M2LoggerT("CallLogger") {}
       
   

    friend class M2LoggerT;    
};




