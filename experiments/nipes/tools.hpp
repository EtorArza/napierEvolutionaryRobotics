#ifndef tools_HPP
#define tools_HPP

#include <chrono>

namespace are{

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

}

#endif