#ifndef tools_HPP
#define tools_HPP

#include <chrono>

class stopwatch
{
public:
    stopwatch(){tic();};
    ~stopwatch(){}
    void tic();
    double toc();
private:
    std::chrono::_V2::system_clock::time_point tt_tic;
};


double get_adjusted_runtime(double progress, double constantExpIncreaseMaxEvalTime, double max_runtime);



#endif