
#define CALLSTACK_MAXLEN 64
 
/*
inline uint32_t get_ebp(void)
{
    __asm__ __volatile__("mov %%ebp, %%eax");
}

int get_stack_depth(void)
{
    uint32_t ebp = get_ebp();
    int stack_depth = 0;
    while(ebp != 0)
    {
        ebp = *(uint32_t *)ebp;
        stack_depth++;
    }
    return stack_depth;
}*/

// gcc sepcific; from http://stupefydeveloper.blogspot.de/2009/09/cc-call-stack-v2.html

/*
struct call {
 const void *address;
 const char *function;
 const char *object;
};

#define _GNU_SOURCE
#include <dlfcn.h>

int backtrace(struct call trace[], int maxlen)
{
 Dl_info dlinfo;
 unsigned int i;

 for (i=0;i<maxlen;++i) {
  switch (i) {
   case 0:
    if(!__builtin_frame_address(0))
     return i;
    trace[i].address = __builtin_return_address(0);
    break;
   case 1:
    if(!__builtin_frame_address(1))
     return i;
    trace[i].address = __builtin_return_address(1);
    break;
   case 2:
    if(!__builtin_frame_address(2))
     return i;
    trace[i].address = __builtin_return_address(2);
    break;
 
   case 63:
    if(!__builtin_frame_address(63))
     return i;
    trace[i].address = __builtin_return_address(63);
    break;
   default:
    return i;
  }

  if (dladdr(trace[i].address, &dlinfo) != 0) {
   trace[i].function = dlinfo.dli_sname;
   trace[i].object = dlinfo.dli_fname;
  }
 }

 return i;
}

int get_stack_depth(void)
{
   struct call trace[CALLSTACK_MAXLEN];
   int i;
   int depth;

   depth = backtrace(trace, CALLSTACK_MAXLEN);
   for (i=0;i<depth;++i)
  printf("%s: %s(%p)\n", trace[i].object, trace[i].function, trace[i].address);
  
   return depth;
}

*/

#ifdef __GNUC__
#include <execinfo.h>
 #define BACKTRACE_BUFFER_SIZE 10000
 
 
static int ref_stack_depth=0;

// #hack
inline int adjust_ref_stack_depth(void)
{
     void *buffer[BACKTRACE_BUFFER_SIZE];
    
   size_t depth;

   ref_stack_depth = backtrace(buffer, BACKTRACE_BUFFER_SIZE);
   
}

int get_stack_depth(void)
{
  
    void *buffer[BACKTRACE_BUFFER_SIZE];
    
   size_t depth;

   depth = backtrace(buffer, BACKTRACE_BUFFER_SIZE);
   
   if (ref_stack_depth > depth )
       return 0;
   
   return depth-ref_stack_depth;
   
}
#else
int get_stack_depth(void)
{
   std::cerr << "get_stack_depth only implemented for linux" << std::endl;
   return 0;
}
#endif
