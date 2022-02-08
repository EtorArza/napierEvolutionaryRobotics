#ifndef tools_HPP
#define tools_HPP

#include <chrono>
#include <string>
#include <fstream>


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


double get_adjusted_runtime(double progress, double constantmodifyMaxEvalTime, double max_runtime);

template <class T>
void append_line_to_file(std::string filename, T data_to_append ) {  
  std::ofstream outfile;
  outfile.open(filename, std::ios_base::app); // append instead of overwrite
  outfile << data_to_append;
  outfile.flush();
  outfile.close();
}

#endif