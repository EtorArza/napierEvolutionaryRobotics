from utils.functionsForcsvPlots import *

dir_with_all_csv = "/home/paran/Dropbox/BCAM/07_estancia_1/code/logs/nipes_5_1_10-49-44-4668-1569205384"
neval_list, _, best_fit_list, avg_fit_list, pop_size_list = load_all_fitnesses(dir_with_all_csv + "/fitnesses.csv", 0)
_, _, best_nov_list, avg_nov_list, _ = load_all_fitnesses(dir_with_all_csv + "/fitnesses.csv",1)
_, eval_time_list = load_eval_time(dir_with_all_csv + "/eval_durations.csv")

plt.plot(neval_list, best_fit_list, label="EnvType0")
plt.plot(neval_list, best_nov_list, label="EnvType1")
plt.legend()
plt.xlabel("Evaluations")
plt.ylabel("Objective function")
plt.show()