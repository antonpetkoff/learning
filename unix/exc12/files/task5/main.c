/** implementation of ./cp source dest */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <err.h>
#include <stdio.h>

int main(int argc, char** argv) {
    char c;
    int source_fd, dest_fd, read_size, write_size;

    if (argc != 3) {
        err(1, "Not enough ");
    }

    printf("%s\n", argv[1]);

    if ((source_fd = open(argv[1], O_RDONLY)) == -1) {
        err(1, "Can't open the source file.");
    }

    if ((dest_fd = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, S_IRWXU)) == -1) {
        close(source_fd);
        err(1, "Can't create open dest file for writing.");
    }

    while ((read_size = read(source_fd, &c, sizeof(c))) > 0) {
        write_size = write(dest_fd, &c, read_size);
        if (write_size != read_size) {
            err(1, "Write to file failed");
            close(source_fd);
            close(dest_fd);
        }
    }

    close(source_fd);
    close(dest_fd);
}

