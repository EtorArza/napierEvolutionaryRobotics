from utils.UpdateParameter import *

paraneter_file = "experiments/nipes/parameters.csv"

parameter_text = """
#preTextInResultFile,string,test5

#resultFile,string,result5.txt

"""

mass_update_parameters(paraneter_file, parameter_text)
