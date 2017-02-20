#include <stdlib.h>
#include <unistd.h>
#include <err.h>
#include <stdio.h>
#include <string.h>

/**
 *  Create a pipe by forking.
 */

int main() {

    int pid;
    int pd[2];
    char * message = "3\n2\n1\n4\n";
    
    pipe(pd);
    pid = fork();

    if (pid < 0) {
        close(pd[0]);
        close(pd[1]);
        err(1, "error creating the child process");
    }

    // pd[0] in the parent != pd[0] in the child
    if (pid > 0) {  // inside the parent = A
        close(pd[0]);
        write(pd[1], message, strlen(message));
        close(pd[1]);
    } else {        // inside the child = B
        close(pd[1]); // close the FD for writes in the child
        dup2(pd[0], 0);
        if (-1 == execl("/usr/bin/sort", "sort", (char *) NULL)) {
            err(1, "failed to execute sort");
        }
        exit(0);
    }

    return 0;
}

