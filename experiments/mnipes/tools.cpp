#include "tools.hpp"
#include "M_NIPES.hpp"
#include <cmath>


class _sort_indices_double
{
   private:
     double* mparr;
   public:
     _sort_indices_double(double* parr) : mparr(parr) {}
     bool operator()(int i, int j) const { return mparr[i]<mparr[j]; }
};

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

double get_adjusted_runtime(double progress, double constantmodifyMaxEvalTime, double max_runtime)
{
    if (progress < 0.0 || progress > 1.0)
    {
        std::cout << "Error, variable progress should be between 0 and 1. Instead, progress = " << progress << std::endl;
    }
    double perc_time = pow(progress, pow(2.0,constantmodifyMaxEvalTime));
    return max_runtime * perc_time;
}


void compute_order_from_double_to_int(double* v, int len, int* order_res, bool reverse){
    
    if (reverse)
    {
        for (int i = 0; i < len; i++)
        {
            v[i] = - v[i];
        }
        
    }


    int* temp = new int[len];
    for (int i = 0; i < len; i++)
    {
        temp[i] = i;
    }
    std::sort(temp, temp+len, _sort_indices_double(v));
    for (int i = 0; i < len; i++)
    {
        order_res[temp[i]] = i;
    }
    
    if (reverse)
    {
        for (int i = 0; i < len; i++)
        {
            v[i] = - v[i];
        }
        
    }
    delete[] temp;
}