#include "tools.hpp"
#include "M_NIPES.hpp"



void stopwatch::tic()
{ 
    tt_tic = are::hr_clock::now();
}

double stopwatch::toc()
{
    auto now = are::hr_clock::now();
    std::chrono::duration<double> time_span = std::chrono::duration_cast<std::chrono::duration<double>>(now - tt_tic);
    return time_span.count();
}
