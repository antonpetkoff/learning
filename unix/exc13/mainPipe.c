#include <unistd.h>
#include <err.h>
#include <stdio.h>
#include <string.h>

/**
 *  Create a pipe by forking.
 */

int main() {

    int pid, read_size;
    int pd[2];
    int c[1 << 10];
    char * message = "Neiko lapa slivi na poleto\n";
    
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
        read_size = read(pd[0], &c, sizeof(c));
        write(1, &c, read_size);    // print to stdout
        close(pd[1]);
        exit(0);
    }

    return 0;
}

