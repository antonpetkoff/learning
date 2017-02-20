#include <unistd.h>
#include <err.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int main(int argc, char ** argv) {
    char buffer[1<<12];
    int pid, status, fd_read, fd_write;
    ssize_t read_size;

    if (argc != 3) {
        err(1, "Exactly 2 arguments must be passed!");
    }

    pid = fork();

    if (pid == -1) {
        err(1, "Error while forking!");
    }

    if (pid > 0) { // parent
        wait(&status);
        printf("Good work, my %d!\n", pid);
    } else { // child
        if ((fd_read = open(argv[1], O_RDONLY)) == -1) {
            err(1, "Error while opening the first file for reading!");
        }

        if ((fd_write = open(argv[2], O_WRONLY | O_CREAT | O_APPEND), S_IWUSR) == -1) {
            close(fd_read);
            err(1, "Error while opening the second file for writing!");
        }

        while ((read_size = read(fd_read, buffer, sizeof(buffer))) > 0) {
            if (read_size != write(fd_write, buffer, read_size)) {
                err(1, "Error while writing content to the second file!");
            }
            //write(fd_write, buffer, sizeof(buffer));
        }
        
        close(fd_read);
        close(fd_write);
        execlp("ls", "ls");
        printf("Father %d, i'm done!\n", getpid());
    }
}
