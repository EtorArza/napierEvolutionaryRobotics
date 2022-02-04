import sys, getopt

def update_param_from_argv(argv):
    parameter_file = ''
    parameter_name = ''
    parameter_value = ''
    try:
        opts, args = getopt.getopt(argv,"h:f:n:v:",["file=","name=", "value="])
    except getopt.GetoptError:
        print('test.py -f <parameter_file_path> -n <parameter_name> -v <new_parameter_value>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('test.py -f <parameter_file_path> -n <parameter_name> -v <new_parameter_value>')
            sys.exit()
        elif opt in ("-f", "--file"):
            parameter_file = arg
        elif opt in ("-n", "--name"):
            parameter_name = arg
        elif opt in ("-v", "--value"):
            parameter_value = arg
    if len(parameter_file) == 0 or len(parameter_name) == 0 or len(parameter_value) == 0:
        print("Parameters -f -n and -v are required. Usage:")
        print('test.py -f <parameter_file_path> -n <parameter_name> -v <new_parameter_value>')
        exit(1)
    update_parameter(parameter_file, parameter_name, parameter_value)

def update_parameter(parameter_file, parameter_name, parameter_value):
    assert not (parameter_file is None or len(parameter_file) == 0)
    assert not (parameter_name is None or len(parameter_name) == 0)
    assert not (parameter_value is None or len(parameter_value) == 0)
    print ('Updating file', parameter_file if len(parameter_file) < 30 else parameter_file[-25:], 'with parameter', parameter_name,"=",parameter_value)
    with open(parameter_file,"r") as f:
        lines = f.readlines()
    for idx, line in enumerate(lines):
        if ("#"+parameter_name) == line.split(",")[0]:
            split_line = line.split(",")
            split_line[2] = parameter_value + "\n"
            lines[idx] = ",".join(split_line)
            with open(parameter_file, "w") as f:
                f.writelines(lines)
            return 0

    print("Error, parameter",parameter_name, "is not present in file", parameter_file)
    return 1




if __name__ == "__main__":
    update_param_from_argv(sys.argv[1:])
