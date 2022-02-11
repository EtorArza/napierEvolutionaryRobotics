#ifndef tools_HPP
#define tools_HPP

#include <chrono>
#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <iostream>
#include <iomanip>
#include <cmath>


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

// https://stackoverflow.com/a/27540115
template<typename T>
std::string iterable_to_str(T begin, T end)
{
    std::stringstream ss;
    bool first = true;
    for (; begin != end; begin++)
    {
        if (!first)
            ss << ", ";
        ss << *begin;
        first = false;
    }
    return ss.str();
}


template <class T>
void PrintArray(T *array, int length)
{
    for (int i = 0; i < length; i++)
    {
        std::cout << std::setprecision(10);
        std::cout << array[i] << ", ";
    }
    std::cout << " " << std::endl;
}

void compute_order_from_double_to_int(double* v, int len, int* order_res, bool reverse);




#endif