#include <unistd.h>
#include <err.h>
#include <stdio.h>

/**
 *  Ще изпълним fork() веднъж, за да изпълним cat в родителя и sort в детето.
 *  Ще пренасочим изхода на cat към входа на sort.
 */

int main(int argc, char ** argv) {
    int pd[2], pid;

    if (argc != 2) {
        err(1, "Exactly one argument must be passed!");
    }

    if (pipe(pd) == -1) {
        err(1, "Error creating pipe!");
    }

    pid = fork();

    if (pid < 0) {
        close(pd[0]);
        close(pd[1]);
        err(1, "Error in first fork!");
    }

    if (pid > 0){ // in main parent we will execute cat
        close(pd[0]); // close the reading end
        
        if (-1 == execlp("cat", "cat", argv[1], (char *) NULL)) {
            err(1, "Failed to execute cat!");
        }
    } else { // in child process we will execute sort
        //close(pd[0]); // close the reading end, because we will execlp() the cat command
        close(pd[1]); // close the writing end
        dup2(pd[0], 0); // take input from stdin (what comes from the parent cat)
        
        if (-1 == execlp("sort", "sort", (char *) NULL)) {
            err(1, "Failed to execute sort!");
        }
    }
    

}

