#ifndef NIPES_HPP
#define NIPES_HPP


#if defined (VREP)
#include "v_repLib.h"
#elif defined (COPPELIASIM)
#include "simLib.h"
#endif

#include "simulatedER/mazeEnv.h"
#include "ARE/learning/ipop_cmaes.hpp"
#include "ARE/learning/Novelty.hpp"
#include "simulatedER/nn2/NN2Individual.hpp"
#include "ARE/Settings.h"
#include "obstacleAvoidance.hpp"
#include "../mnipes/tools.hpp"

namespace are{


typedef enum DescriptorType{
    FINAL_POSITION = 0,
    VISITED_ZONES = 1
}DescriptorType;

class NIPESIndividual : public sim::NN2Individual
{
public:
    NIPESIndividual() : sim::NN2Individual(){}
    NIPESIndividual(const Genome::Ptr& morph_gen,const NNParamGenome::Ptr& ctrl_gen)
        : sim::NN2Individual(morph_gen,ctrl_gen){}
    NIPESIndividual(const NIPESIndividual& ind)
        : sim::NN2Individual(ind),
          visited_zones(ind.visited_zones),
          descriptor_type(ind.descriptor_type){}


    Eigen::VectorXd descriptor() override;
    void set_visited_zones(const Eigen::MatrixXi& vz){visited_zones = vz;}
    void set_descriptor_type(DescriptorType dt){descriptor_type = dt;}
private:

    Eigen::MatrixXi visited_zones;
    DescriptorType descriptor_type = FINAL_POSITION;
};

class NIPES : public EA
{
public:
    NIPES() : EA(){}
    NIPES(const misc::RandNum::Ptr& rn, const settings::ParametersMapPtr& param) : EA(rn, param){}
    ~NIPES(){
        cmaStrategy.reset();
    }

    void init() override;
    void epoch() override;
    void init_next_pop() override;
    bool update(const Environment::Ptr&) override;

    void setObjectives(size_t indIdx, const std::vector<double> &objectives) override;

    bool is_finish() override;
    bool finish_eval(const Environment::Ptr &env) override;
    void write_measure_ranks_to_results();
    void updateNoveltyEnergybudgetArchive();
    void cma_iteration();
    void modifyMaxEvalTime_iteration();
    void print_fitness_iteration();
    std::string compute_population_genome_hash();
    std::string getIndividualHash(Individual::Ptr ind);



    bool restarted(){return !cmaStrategy->log_stopping_criterias.empty();}
    std::string pop_stopping_criterias(){
        std::string res = cmaStrategy->log_stopping_criterias.back();
        cmaStrategy->log_stopping_criterias.pop_back();
        return res;
    }
    const std::vector<Eigen::VectorXd> &get_archive(){return archive;}

protected:
    IPOPCMAStrategy::Ptr cmaStrategy;
    cma::CMASolutions best_run;
    bool _is_finish = false;
    std::vector<Eigen::VectorXd> archive;
    int n_iterations_isReevaluating = 0;
    float currentMaxEvalTime = 0; 

    stopwatch sw = stopwatch();
    stopwatch total_time_sw = stopwatch();
    double best_fitness = -__DBL_MAX__;
    bool isReevaluating=false;

    std::string result_filename;
    std::string subexperiment_name;
};

}

#endif //NIPES_HPP


