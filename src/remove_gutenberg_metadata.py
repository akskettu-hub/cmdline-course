from sys import argv, stderr

START = "*** START OF"
STOP  = "*** END OF"

if __name__=="__main__":
    if len(argv) != 2:
        print("USAGE: %s input_file output_file" % argv[0], file=stderr)
        exit(1)

    ifile = open(argv[1])
    printing = 0
    for line in ifile:
        if STOP in line:
            break
        if printing: 
            print(line,end="")
        if START in line:
            printing = 1
