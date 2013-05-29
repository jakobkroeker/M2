
#include <fstream>
#include <stdexcept>

template <class DerivedLogger> 
void    M2LoggerT<DerivedLogger>::setPriority(int newPriority)
{
    DerivedLogger& logger = DerivedLogger::get();
    assert ( newPriority>=logger.minPriority&& newPriority<=logger.maxPriority );
    logger.priority_m = newPriority;
}

template <class DerivedLogger> 
int     M2LoggerT<DerivedLogger>::priority( )
{
    DerivedLogger& logger= DerivedLogger::get();

    return logger.priority_m ;
}

template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::log(int priority, const std::string& message)
{
    DerivedLogger& logger=  M2LoggerT::get() ;
    logger.iLog( priority,message);
}

template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::info(  const std::string& message)
{
        M2LoggerT<DerivedLogger>::log(0,  message);
}
template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::warn(  const std::string& message)
{
    M2LoggerT<DerivedLogger>::log(1,  message);
}
template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::error(  const std::string& message)
{
    M2LoggerT<DerivedLogger>::log(2,  message);
}

template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::debug(  const std::string& message)
{
    M2LoggerT<DerivedLogger>::log(3,  message);
}

template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::save(std::string filename)
{
    DerivedLogger& logger=  M2LoggerT::get() ;
    logger.iSave(  filename);
}


template <class DerivedLogger> 
bool     M2LoggerT<DerivedLogger>::hasMessage(const std::string & msg) 
{
    DerivedLogger& logger= M2LoggerT::get();
    return logger.iHasMessage(msg);
}


template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::print() 
{
    DerivedLogger& logger= M2LoggerT::get();
    logger.iPrint();
}

 
template <class DerivedLogger> 
void     M2LoggerT<DerivedLogger>::useStackDepth(bool yn)  
{
    DerivedLogger& logger= M2LoggerT::get();
    logger.bUseStackDepth_m=yn;
}


template <class DerivedLogger> 
bool     M2LoggerT<DerivedLogger>::useStackDepth()  
{
    DerivedLogger& logger= M2LoggerT::get();
    return logger.bUseStackDepth_m ;
}
        
template <class DerivedLogger> 
bool    M2LoggerT<DerivedLogger>::iHasMessage(const std::string & msg) 
{
    for (const std::string &x : logs_m) 
    {
        if ( not ( x.find(msg) == std::string::npos) ) 
            return true;
    }
    return false;
}
        
template <class DerivedLogger> 
void M2LoggerT<DerivedLogger>:: iPrint( ) 
{
    
    std::ostream& os = *(  osp_m);
    os <<   std::endl;
    os << "#################"   << "# Logs of " <<  name() << std::endl;

    std::ostream_iterator<std::string> outIter( os, "\n" );
    copy(  logs_m.begin(),  logs_m.end(), outIter );
    os <<   std::endl;
        
}
        
template <class DerivedLogger> 
void M2LoggerT<DerivedLogger>::iLog( int priority, const std::string& message)
{
    //assert (priority>=minPriority&& priority<=maxPriority); 
    if (priority_m>=priority and priority>=minPriority)
    {
        //std::cerr << "priority mathced"<< std::endl;
        std::string  local_message(message);
        
        // std::cerr << "message" << message << std::endl;
        
        if ( useStackDepth() )
        { 
            std::ostringstream ss;
            int stackDepth = get_stack_depth();
            //std::cerr << "stack_depth:" << stackDepth << std::endl;
            ss << stackDepth;
            
            local_message = std::string("# ") + std::string(  ss.str() ) + std::string( 3*stackDepth, ' '  ) + std::string(":" ) + local_message;
        }
        // std::cerr << "local_message"<<local_message << std::endl;
        logs_m.push_back(  local_message );
    } 
}


template <class DerivedLogger> 
void M2LoggerT<DerivedLogger>::iSave(std::string filename)
{
    std::ofstream logfile;
    logfile.open (filename);
    if (not logfile.good()) 
    {
        throw std::runtime_error("open file '"+std::string(filename)+"' failed");
    }
    std::ostream_iterator<std::string> outIter( logfile, "\n" );
    copy(  logs_m.begin(),  logs_m.end(), outIter );

    if (not logfile.good()) 
    {
        throw std::runtime_error("writing to file '"+std::string(filename)+"' failed");
    }
    logfile.close();
}
