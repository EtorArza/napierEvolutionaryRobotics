#include "tools.hpp"
#include "NIPES.hpp"


using namespace are;

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
