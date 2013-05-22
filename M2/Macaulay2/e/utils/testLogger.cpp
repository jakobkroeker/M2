

// g++ testLogger.cpp -std=gnu++11 -ldl -rdynamic -O3

#include "M2Logger.h"

__attribute__((noinline)) 
void bar(int par)
{
    M2Logger::log(2, "bar");
    
}

__attribute__((noinline)) 
void foo()
{
    M2Logger::log(1, "test sdf");
    bar(5);
    
     M2Logger::warn( "leave " + std::string(__FUNCTION__) );
     M2log (3, "foobar") ;
     CallLogger::error( "foobar" );
}


int main()
{
    adjust_ref_stack_depth(); // optional
    
      std::cout <<  std::endl;
     M2Logger::setPriority(2);
    M2Logger::useStackDepth(true);
      M2Logger::log(1, "main");
    
      foo();
    
    std::cout << "M2Logger logged foobar: " << (M2Logger::hasMessage("foobar") ? "true"  :"false") << std::endl;
    std::cout << "M2Logger logged test: " << ( M2Logger::hasMessage("test")  ? "true"  :"false") << std::endl;
    
    M2Logger::print();
    CallLogger::print();
       std::cout <<  std::endl;
       
      std::cout <<    get_stack_depth() << std::endl;

    
      M2Logger::save("M2log.log");
      
        M2Logger::save("M2log.#,%$log/");
}