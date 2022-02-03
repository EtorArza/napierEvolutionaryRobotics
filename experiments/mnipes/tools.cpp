#include "tools.hpp"
#include "M_NIPES.hpp"
#include <cmath>


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

double get_adjusted_runtime(double progress, double constantExpIncreaseMaxEvalTime, double max_runtime)
{
    if (progress < 0.0 || progress > 1.0)
    {
        std::cout << "Error, variable progress should be between 0 and 1. Instead, progress = " << progress << std::endl;
    }
    double perc_time = pow(progress, pow(2.0,constantExpIncreaseMaxEvalTime));
    return max_runtime * perc_time;
}